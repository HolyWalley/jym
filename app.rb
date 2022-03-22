# frozen_string_literal: true

require "bundler/setup"

# Gems
require "dry/system/container"
# require "dry-types"
require "hanami/api"

require 'sequel'
require 'sqlite3'

require 'dry-initializer'

# module Types
#   include Dry.Types()
# end

require_relative "./app/models/application_model"
require_relative "./app/actions/application_action"
require_relative "./app/operations/application_operation"

DB = Sequel.sqlite

DB.create_table :excercises do
  primary_key :id
  String :name
end

DB.create_table :trainings do
  primary_key :id
  String :name
  DateTime :started_at
  DateTime :finished_at
end

DB.create_table :training_sets do
  primary_key :id
  Integer :reps
  Float :weight

  Integer :excercise_id
  Integer :training_id
end

class Jym < Dry::System::Container
  configure do |config|
    config.root = Pathname('./app')

    config.component_dirs.add 'repositories'
    config.component_dirs.add 'operations'
    config.component_dirs.add 'actions'
  end
end

Jym.finalize!
Import = Jym.injector

class Application < Hanami::API
  scope "api" do
    scope "v1" do
      post "/excercises", to: Jym["excercises.create_action"]
      post "/trainings", to: Jym["trainings.create_action"]
      post "/trainings/:id/sets", to: Jym["training_sets.create_action"]

      options "/trainings" do
        [
          200,
          {
            "Access-Control-Allow-Origin" => "*",
            "Access-Control-Request-Method" => "POST",
            "Access-Control-Allow-Headers" => "Accept, Accept-Language, Content-Language, Content-Type"
          },
          "Allow: POST"
        ]
      end

      options "/trainings/:id/sets" do
        [
          200,
          {
            "Access-Control-Allow-Origin" => "*",
            "Access-Control-Request-Method" => "POST",
            "Access-Control-Allow-Headers" => "Accept, Accept-Language, Content-Language, Content-Type"
          },
          "Allow: POST"
        ]
      end

      get "/trainings" do
        [
          200,
          {
            "Content-Type" => "application/json",
            "Access-Control-Allow-Origin" => "*"
          },
          DB[:trainings].all.to_json
        ]
      end

      get "/trainings/:id" do
        [
          200,
          {
            "Content-Type" => "application/json",
            "Access-Control-Allow-Origin" => "*"
          },
          DB[:trainings].where(id: params[:id]).first.to_json
        ]
      end

      get "/trainings/:id/sets" do
        training_sets = DB[:training_sets].where(training_id: params[:id]).all
        excercises = training_sets.map { _1[:excercise_id] }.uniq
        excercises = DB[:excercises].where(id: excercises)

        training_sets.each do |training_set|
          training_set[:excercise] = excercises.find { |exc| exc[:id] == training_set[:excercise_id] }
          training_set.delete(:excercise_id)
        end

        [
          200,
          {
            "Content-Type" => "application/json",
            "Access-Control-Allow-Origin" => "*"
          },
          training_sets.to_json
        ]
      end

      get "/excercises" do
        [
          200,
          {
            "Content-Type" => "application/json",
            "Access-Control-Allow-Origin" => "*"
          },
          DB[:excercises].all.to_json
        ]
      end
    end
  end
end

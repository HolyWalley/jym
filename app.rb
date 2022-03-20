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
      post "/excercises", to: Jym['excercises.create_action']
      post "/trainings", to: Jym['trainings.create_action']
      post "/trainings/:id/sets", to: Jym['training_sets.create_action']

      get "/trainings" do
        [
          200,
          { 'Content-Type' => 'application/json' },
          DB[:trainings].all.to_json
        ]
      end

      get "/excercises" do
        [
          200,
          { 'Content-Type' => 'application/json' },
          DB[:excercises].all.to_json
        ]
      end
    end
  end
end

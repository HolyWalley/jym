# frozen_string_literal: true

require_relative "../../models/excercise"

module Excercises
  class Create < ApplicationOperation
    include Import["excercise_repository"]

    option :excercise_model, default: -> { Excercise }

    def call(params)
      excercise = excercise_model.new(**params)
      excercise_repository.persist(excercise)
    end
  end
end

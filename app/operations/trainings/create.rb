# frozen_string_literal: true

require_relative "../../models/training"

module Trainings
  class Create < ApplicationOperation
    include Import["training_repository"]
    option :training_model, default: -> { Training }

    def call(name: nil)
      training = training_model.start(name:)
      training_repository.persist(training)
      training
    end
  end
end

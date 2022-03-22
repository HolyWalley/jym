# frozen_string_literal: true

require_relative "../../models/training_set"

module TrainingSets
  class Create < ApplicationOperation
    include Import["training_set_repository"]
    option :set_model, default: -> { TrainingSet }

    def call(params)
      training_set = set_model.log(**params)
      training_set_repository.persist(training_set)
      training_set
    end
  end
end

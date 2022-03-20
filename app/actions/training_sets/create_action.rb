# frozen_string_literal: true

module TrainingSets
  class CreateAction < ApplicationAction
    def call(_env)
      [200, {}, 'OK']
    end
  end
end

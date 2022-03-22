# frozen_string_literal: true

module Trainings
  class CreateAction < ApplicationAction
    include Import[create_training: "trainings.create"]

    def call(env)
      request = Rack::Request.new(env)
      body = request.body.read
      body_parsed = JSON.parse(body, symbolize_names: true)

      permitted_params = body_parsed.fetch(:training).slice(:name)

      training = create_training.call(**permitted_params)
      # parse operation response and change response
      [200, { "Content-Type" => "application/json" }, [training.to_h.to_json]]
    end
  end
end

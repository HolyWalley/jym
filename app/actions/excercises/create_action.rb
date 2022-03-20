# frozen_string_literal: true

module Excercises
  class CreateAction < ApplicationAction
    include Import[create_excercise: "excercises.create"]

    def call(env)
      request = Rack::Request.new(env)
      body = request.body.read
      body_parsed = JSON.parse(body, symbolize_names: true)

      permitted_params = body_parsed.fetch(:excercise).slice(:name)

      excercise = Excercises::Create.new.call(permitted_params)

      [200, { 'Content-Type' => 'application/json' }, [excercise.to_h.to_json]]
    end
  end
end

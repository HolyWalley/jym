# frozen_string_literal: true

module TrainingSets
  class CreateAction < ApplicationAction
    include Import[create_set: "training_sets.create"]

    def call(env)
      request = Rack::Request.new(env)
      body = request.body.read
      body_parsed = JSON.parse(body, symbolize_names: true)

      router_params = request.env["router.params"]
      training_id = router_params[:id]

      permitted_params = body_parsed.fetch(:training_set).slice(:reps, :weight, :excercise_id)

      training_set = create_set.call(**permitted_params, training_id:)

      [200, { "Content-Type" => "application/json" }, [training_set.to_h.to_json]]
    end
  end
end

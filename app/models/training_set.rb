# frozen_string_literal: true

TrainingSet = Struct.new(:id, :reps, :weight, :excercise, :training, keyword_init: true) do
  def self.log(reps:, weight:, excercise_id:, training_id:)
    training = Training.new(id: training_id)
    excercise = Excercise.new(id: excercise_id)

    TrainingSet.new(reps:, weight:, excercise:, training:)
  end
end.include(ApplicationModel)

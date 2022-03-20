# frozen_string_literal: true

TrainingSet = Struct.new(:id, :reps, :weight, :excercise, :training, keyword_init: true) do
  def self.build(params)
    new({ id: nil, **params.slice(:reps, :weight, :excercise, :training) })
  end
end.include(ApplicationModel)

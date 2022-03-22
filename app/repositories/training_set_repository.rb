# frozen_string_literal: true

class TrainingSetRepository
  def persist(training_set)
    if training_set.id
      DB[:training_sets].where(id: training_set.id).update(
        reps: training_set.reps,
        weight: training_set.weight,
        excercise_id: training_set.excercise.id,
        training_id: training_set.training.id
      )
    else
      id = DB[:training_sets].insert(
        reps: training_set.reps,
        weight: training_set.weight,
        excercise_id: training_set.excercise.id,
        training_id: training_set.training.id
      )
      training_set.id = id
    end

    training_set
  end
end

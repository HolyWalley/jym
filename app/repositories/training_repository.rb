# frozen_string_literal: true

class TrainingRepository
  def persist(training)
    DB.transaction do
      unless training.id
        training_id = DB[:trainings].insert(
          name: training.name,
          started_at: training.started_at,
          finished_at: training.finished_at
        )

        training.sets.each do |set|
          DB[:training_sets].insert(
            reps: set.reps,
            weight: set.weight,
            excercise_id: set.excercise.id,
            training: training_id
          )
        end
      else
      end
    end
  end
end

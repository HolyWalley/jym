# frozen_string_literal: true

class TrainingRepository
  def persist(training)
    if training.id
      DB[:trainings].where(id: training.id).update(
        name: training.name,
        started_at: training.started_at,
        finished_at: training.finished_at
      )
    else
      training_id = DB[:trainings].insert(
        name: training.name,
        started_at: training.started_at,
        finished_at: training.finished_at
      )
      training.id = training_id
    end

    training
  end

  def by_pk(pk)
    training_params = DB[:trainings].where(id: pk).first

    Training.new(
      id: training_params[:id],
      name: training_params[:name],
      started_at: training_params[:name],
      finished_at: training_params[:name]
    )
  end

  def by_pk_with_sets(pk)
    training_params = DB[:trainings].where(id: pk).first
    sets_params = DB[:training_sets].where(training_id: pk)

    training = Training.new(
      id: training_params[:id],
      name: training_params[:name],
      started_at: training_params[:name],
      finished_at: training_params[:name]
    )

    sets = sets_params.map do |set_params|
      TrainingSet.new(
        id: set_params[:id],
        reps: set_params[:reps],
        weight: set_params[:weight],
        training: training
      )
    end

    training.sets = sets

    training
  end
end

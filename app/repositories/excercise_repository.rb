# frozen_string_literal: true

class ExcerciseRepository
  def persist(excercise)
    unless excercise.id
      id = DB[:excercises].insert(name: excercise.name)
      excercise.id = id
    else
      DB[:excercises].where(id: excercise.id).update(name: excercise.name)
    end

    excercise
  end
end

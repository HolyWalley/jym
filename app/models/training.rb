# frozen_string_literal: true

require_relative "./training_set"

Training = Struct.new(:id, :name, :started_at, :finished_at, :sets, keyword_init: true) do
  def self.start(name: nil)
    started_at = DateTime.now
    name ||= "Training #{started_at.strftime('%d/%m/%Y')}"

    new({ id: nil, name:, started_at:, sets: [], finished_at: nil })
  end

  def finish
    self.finished_at = DateTime.now
  end
end.include(ApplicationModel)

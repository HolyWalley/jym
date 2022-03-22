# frozen_string_literal: true

Excercise = Struct.new(:id, :name, keyword_init: true) do
end.include(ApplicationModel)

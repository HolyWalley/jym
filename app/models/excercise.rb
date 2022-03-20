# frozen_string_literal: true

Excercise = Struct.new(:id, :name, keyword_init: true) do
  def self.build(params)
    new({ id: nil, name: params[:name] })
  end
end.include(ApplicationModel)

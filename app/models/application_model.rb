# frozen_string_literal: true

module ApplicationModel
  def self.included(base)
    base.private_class_method :new
  end
end

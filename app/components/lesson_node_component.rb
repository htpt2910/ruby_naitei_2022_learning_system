# frozen_string_literal: true

class LessonNodeComponent < ViewComponent::Base
  include Devise::Controllers::Helpers

  def initialize lesson:, classes: ""
    super
    @lesson = lesson
    @classes = classes
  end
end

# frozen_string_literal: true

class Admin::LessonFormComponent < ViewComponent::Base
  include LessonsHelper
  include ApplicationHelper

  def initialize lesson:
    super
    @lesson = lesson
  end
end

# frozen_string_literal: true

class CourseCardComponent < ViewComponent::Base
  include Devise::Controllers::Helpers
  def initialize course:
    super
    @course = course
  end

  def link_to_course
    course_path @course
  end
end

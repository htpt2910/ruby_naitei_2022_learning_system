class LessonsController < ApplicationController
  before_action :load_lesson, only: :show
  def show
    @exam = current_user.exams.build
    @exam.lesson = @lesson
  end

  private
  def load_lesson
    @lesson = Lesson.find_by id: params[:id]
    return if @lesson.present?

    flash[:error] = t "lessons.lesson_not_found"
    redirect_to root_path
  end
end

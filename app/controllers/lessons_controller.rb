class LessonsController < ApplicationController
  load_and_authorize_resource param_method: :lesson_params

  def current_ability
    @current_ability ||= LessonAbility.new(current_user)
  end

  def index
    @lessons = Lesson.all
  end

  def show
    return unless cannot? :update, @exam

    @exam = current_user.exams.build
    @exam.lesson = @lesson
  end

  def edit; end

  def update
    if @lesson.update lesson_params
      flash[:success] = t ".lesson_update_success"
      redirect_to lesson_path @lesson
    else
      flash[:error] = t ".lesson_update_fail"
      render :edit
    end
  end

  def lesson_params
    params.require(:lesson).permit Lesson::UPDATEDB_ATTRS
  end
end

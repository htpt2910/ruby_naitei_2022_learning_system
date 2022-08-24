class Admin::LessonsController < Admin::BaseController
  before_action :find_lesson

  def index
    @lessons = Lesson.all
  end

  def show; end

  def edit; end

  def update
    if @lesson.update lesson_params
      flash[:success] = t ".lesson_update_success"
    else
      flash[:error] = t ".lesson_update_fail"
    end
    redirect_to admin_lesson_path @lesson
  end

  def destroy
    if @lesson.destroy
      flash[:success] = t ".lesson_destroy_success"
    else
      flash[:error] = t ".lesson_destroy_fail"
    end
    redirect_back fallback_location: admin_root_path
  end

  private
  def lesson_params
    params.require(:lesson).permit Lesson::UPDATEDB_ATTRS
  end

  def find_lesson
    @lesson = Lesson.find_by id: params[:id]
    return if @lesson

    flash[:error] = t ".lesson_not_exist"
    redirect_to admin_root_path
  end
end

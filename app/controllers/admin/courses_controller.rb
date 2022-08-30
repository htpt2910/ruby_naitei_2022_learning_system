class Admin::CoursesController < Admin::BaseController
  include Pagy::Backend
  before_action :guard_admin
  before_action :set_course, only: %i(show edit update destroy)

  def index
    @search_query = Course.ransack params[:q]
    @pagy, @courses = pagy @search_query.result
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new course_params
    @course.order = Course.all.length + 1
    if @course.save
      flash[:success] = t ".course_create_success"
    else
      flash[:error] = t ".course_create_fail"
    end
    redirect_to admin_root_path
  end

  def show; end

  def edit; end

  def update
    if @course.update course_params
      flash[:success] = t ".course_update_success"
      redirect_to admin_course_path @course
    else
      flash[:error] = t ".course_update_fail"
      render :edit
    end
  end

  def destroy
    if @course.destroy
      flash[:success] = t ".course_delete_success"
    else
      flash[:error] = t ".course_delete_fail"
    end
    redirect_to admin_courses_path
  end

  private

  def course_params
    params.require(:course).permit :name, :description,
                                   lessons_attributes: %i(
                                     id name description order
                                   )
  end

  def set_course
    @course = Course.find_by id: params[:id]
    return if @course.present?

    flash[:error] = t ".course_not_found"
    redirect_to admin_root_path
  end
end

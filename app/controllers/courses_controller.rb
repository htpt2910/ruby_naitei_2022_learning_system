class CoursesController < ApplicationController
  include Pagy::Backend
  load_and_authorize_resource param_method: :course_params

  def current_ability
    @current_ability ||= CourseAbility.new(current_user)
  end

  def index
    @search_query = Course.ransack params[:q]
    @pagy, @courses = pagy @search_query.result
  end

  def show; end

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
    redirect_to courses_path
  end

  def edit; end

  def update
    if @course.update course_params
      flash[:success] = t ".course_update_success"
      redirect_to course_path @course
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
    redirect_to courses_path
  end

  private

  def course_params
    params.require(:course).permit :name, :description,
                                   lessons_attributes: %i(
                                     id name description order
                                   )
  end
end

class ExamsController < ApplicationController
  include ExamsHelper
  load_and_authorize_resource param_method: :exam_params

  def current_ability
    @current_ability ||= ExamAbility.new(current_user)
  end

  def index
    @exams = if current_user.admin?
               Exam.all
             else
               current_user.exams
             end
  end

  def new
    @exam = Exam.new
  end

  def create
    @exam = Exam.create exam_params.merge user_id: current_user.id
    respond_to{|format| format.js}
  end

  def show
    return redirect_to edit_exam_path(@exam) unless @exam.finished?
  end

  def edit
    return redirect_to @exam if @exam.finished?
  end

  def update
    if @exam.update exam_params
      flash[:success] = t ".success"
      redirect_to exam_path(@exam)
    else
      flash[:error] = t ".fail"
      redirect_to edit_exam_path(@exam)
    end
  end

  private

  def exam_params
    params.require(:exam).permit Exam::PERMIT_ATTRIBUTES
  end
end

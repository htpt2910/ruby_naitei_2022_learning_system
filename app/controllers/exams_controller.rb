class ExamsController < BaseController
  before_action :load_exam, only: %i(show edit update)

  def new
    @exam = Exam.new
  end

  def create
    @exam = Exam.create exam_params.merge user_id: current_user.id
    respond_to{|format| format.js}
  end

  def index
    @exams = current_user.exams
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

  def load_exam
    @exam = Exam.find_by id: params[:id]
    return if @exam

    flash[:error] = t "exams.not_found"
    redirect_to exams_path
  end
end

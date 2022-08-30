class ExamsController < BaseController
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
    @exam = Exam.new exam_params
    sample_questions
    if @exam.save
      flash[:success] = t ".success"
      redirect_to edit_exam_path(@exam)
    else
      flash[:error] = t ".fail"
      redirect_to @exam.lesson
    end
  end

  def show
    return redirect_to edit_exam_path(@exam) unless @exam.is_finished
  end

  def edit
    return redirect_to @exam if @exam.is_finished
  end

  def update
    if @exam.update exam_params.merge is_finished: true
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

  def sample_questions
    word_ids = helpers.sample_word_ids_from @exam.lesson
    word_ids.each do |chosen_word_id|
      sampled_word_ids = helpers.sample_3_wrong_word_ids word_ids,
                                                         chosen_word_id
      exam_question = @exam.exam_questions.build true_answer_id: chosen_word_id
      sampled_word_ids.each do |sampled_word_id|
        exam_question.wrong_answers.build word_id: sampled_word_id
      end
    end
  end
end

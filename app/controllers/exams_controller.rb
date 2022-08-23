class ExamsController < ApplicationController
  before_action :load_exam, only: %i(show edit update)

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

  def index; end

  def show; end

  def edit; end

  def update; end

  private

  def exam_params
    params.require(:exam).permit Exam::PERMIT_ATTRIBUTES
  end

  def load_exam
    @exam = Exam.find_by id: params[:id]
    return if @exam.present?

    flash[:error] = t "exams.not_found"
    redirect_to exams_path
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

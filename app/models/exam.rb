class Exam < ApplicationRecord
  PERMIT_ATTRIBUTES = [:lesson_id,
                      {exam_questions_attributes: %i(id user_answer_id)}].freeze

  belongs_to :user
  belongs_to :lesson
  has_many :exam_questions, dependent: :destroy
  accepts_nested_attributes_for :exam_questions

  before_create :assert_learn_all_words, :sample_questions
  before_update :assert_unfinished, :calculate_score

  delegate :name, to: :lesson, prefix: true
  delegate :course_name, to: :lesson

  def passed?
    return false unless finished?

    score / exam_questions.length >= Settings.exam.min_passed_percentage_80
  end

  def finished?
    score.present?
  end

  class << self
    def by_user_on_lesson user_id, lesson_id
      where(user_id: user_id, lesson_id: lesson_id)
    end
  end

  private
  def sample_questions
    word_ids = lesson.sample_word_ids(
      Settings.exam.max_questions_per_exam_40
    )
    word_ids.each do |chosen_word_id|
      sampled_word_ids = sample_3_wrong_word_ids word_ids,
                                                 chosen_word_id
      exam_question = exam_questions.build true_answer_id: chosen_word_id
      sampled_word_ids.each do |sampled_word_id|
        exam_question.wrong_answers.build word_id: sampled_word_id
      end
    end
  end

  def sample_3_wrong_word_ids word_ids, true_word_id
    (word_ids - [true_word_id]).sample(3)
  end

  def assert_learn_all_words
    return if lesson.learned_all_words_by? user

    errors.add :base, :not_learned_all_words
    throw :abort
  end

  def assert_unfinished
    return unless finished?

    errors.add :base, :already_finished
    throw :abort
  end

  def calculate_score
    self.score = exam_questions.correctly_answered.count
  end
end

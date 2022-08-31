class Lesson < ApplicationRecord
  belongs_to :course
  has_many :words, dependent: :destroy

  UPDATEDB_ATTRS = [:name, :description, {
    words_attributes: %i(id definition translation)
  }].freeze

  accepts_nested_attributes_for :words, allow_destroy: true,
                                          reject_if: :reject_word

  validates :name, presence: true,
                   length: {maximum: Settings.lesson.length.name_max_255}
  validates :description, presence: true,
         length: {
           maximum: Settings.lesson.length.max_1000
         }

  delegate :name, to: :course, prefix: true

  def learned_all_words_by? user
    user.learned_words.where(lesson_id: id).count == words.count
  end

  def test_completed_by? user
    Exam.by_user_on_lesson(user.id, id).any?(&:passed?)
  end

  def completed_by? user
    learned_all_words_by? user
    test_completed_by? user
  end

  def sample_word_ids number_of_words
    words.pluck(:id).sample(number_of_words)
  end

  private
  def reject_word word_attrs
    word_attrs[:definition].blank?
  end
end

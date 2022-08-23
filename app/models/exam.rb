class Exam < ApplicationRecord
  PERMIT_ATTRIBUTES = %i(user_id lesson_id).freeze
  belongs_to :user
  belongs_to :lesson
  has_many :exam_questions, dependent: :destroy
  accepts_nested_attributes_for :exam_questions
end

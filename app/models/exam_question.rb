class ExamQuestion < ApplicationRecord
  belongs_to :exam
  has_many :wrong_answers, class_name: ExamAnswer.name,
                          dependent: :destroy
  has_one :true_answer, class_name: Word.name,
                        foreign_key: :id,
                        primary_key: :true_answer_id,
                        dependent: :destroy
  accepts_nested_attributes_for :wrong_answers, allow_destroy: true
end

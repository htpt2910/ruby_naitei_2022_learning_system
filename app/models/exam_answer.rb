class ExamAnswer < ApplicationRecord
  belongs_to :word
  belongs_to :exam_question
end

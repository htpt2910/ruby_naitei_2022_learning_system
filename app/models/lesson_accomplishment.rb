class LessonAccomplishment < ApplicationRecord
  belongs_to :lesson
  belongs_to :user
  enum status: {
    learning: 0,
    completed: 1
  }
end

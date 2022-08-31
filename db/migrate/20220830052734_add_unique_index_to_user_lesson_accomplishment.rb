class AddUniqueIndexToUserLessonAccomplishment < ActiveRecord::Migration[6.1]
  def change
    add_index :lesson_accomplishments, [:lesson_id, :user_id], unique: true
  end
end

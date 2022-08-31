class AddStatusToLessonAccomplishment < ActiveRecord::Migration[6.1]
  def change
    add_column :lesson_accomplishments, :status, :integer, default: 0
  end
end

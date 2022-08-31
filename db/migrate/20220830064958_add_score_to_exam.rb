class AddScoreToExam < ActiveRecord::Migration[6.1]
  def change
    add_column :exams, :score, :integer, null: true
    remove_column :exams, :is_finished, :boolean
  end
end

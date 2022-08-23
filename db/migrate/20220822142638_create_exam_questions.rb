class CreateExamQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :exam_questions do |t|
      t.references :true_answer, null: false, foreign_key: {to_table: :words}
      t.references :user_answer, null: true, foreign_key: {to_table: :words}
      t.references :exam, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end

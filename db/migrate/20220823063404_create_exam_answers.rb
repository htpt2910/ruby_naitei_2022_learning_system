class CreateExamAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :exam_answers do |t|
      t.references :exam_question, null: false, foreign_key: true, index: true
      t.references :word, null: false, foreign_key: true, index: true

      t.timestamps
      t.index [:exam_question_id, :word_id], unique: true
    end
  end
end

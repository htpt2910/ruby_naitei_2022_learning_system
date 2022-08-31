class AddUniqueIndexToUserLearnWord < ActiveRecord::Migration[6.1]
  def change
    add_index :user_learn_words, [:word_id, :user_id], unique: true
  end
end

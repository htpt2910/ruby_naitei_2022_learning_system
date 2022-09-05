class Word < ApplicationRecord
  belongs_to :lesson
  has_many :user_learn_words, dependent: :destroy
  WORD_ATTRS = [:definition, :translation].freeze

  validates :definition, :translation, presence: true,
  length: {maximum: Settings.word.max_length_255}

  scope :latest, ->{order(created_at: :desc)}
  scope :oldest, ->{order(created_at: :asc)}

  class << self
    def with_learned_by user
      select(
        sanitize_sql_array(
          [
            %{
              words.*,
              (
                SELECT user_learn_words.id
                FROM user_learn_words
                WHERE user_learn_words.word_id = words.id
                AND user_learn_words.user_id = ?
              ) AS user_learn_words_id
            },
            user.id
          ]
        )
      )
        .order(
          Arel.sql("CASE WHEN user_learn_words_id IS NULL THEN 0 ELSE 1 END")
        )
        .oldest
    end
  end
end

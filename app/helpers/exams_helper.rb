module ExamsHelper
  def sample_word_ids_from lesson
    lesson
      .words
      .pluck(:id)
      .sample(Settings.exam.max_questions_per_exam_40)
  end

  def sample_3_wrong_word_ids word_ids, true_word_id
    (word_ids - [true_word_id]).sample(3)
  end
end

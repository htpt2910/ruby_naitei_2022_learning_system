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

  def btn_color_base_on_answer question, answer
    if question.true_answer.id == answer.id
      if question.user_answer_id.nil?
        "btn-warning"
      else
        "btn-success"
      end
    elsif question.true_answer.id != answer.id &&
          answer.id == question.user_answer_id
      "btn-danger"
    else
      "btn-outline-secondary"
    end
  end

  def set_answers; end
end

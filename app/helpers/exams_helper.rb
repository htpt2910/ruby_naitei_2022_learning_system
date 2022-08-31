module ExamsHelper
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
end

class UserLearnWordsController < ApplicationController
  def create
    word = Word.find_by id: params[:word_id]
    if word.nil?
      respond_to{|format| format.js{render status: :unprocessable_entity}}
      return
    end
    word_association = current_user.learn word
    respond_to do |format|
      format.js do
        render json: {data: word_association.as_json(only: [:id, :word_id])}
      end
    end
  end

  def destroy
    @user_learn_word = UserLearnWord.find_by id: params[:id]
    if @user_learn_word.destroy
      message_type = :success
      message = t ".success"
    else
      message_type = :error
      message = t ".error"
    end

    respond_to do |format|
      format.html do
        flash[message_type] = message
        redirect_to word.lesson
      end

      format.js{render json: {status: message_type, message: message}}
    end
  end
end

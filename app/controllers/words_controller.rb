class WordsController < ApplicationController
  load_and_authorize_resource param_method: :lesson_params
  before_action :load_word, only: :destroy

  def current_ability
    @current_ability ||= WordAbility.new(current_user)
  end

  def index
    @words = if current_user.admin?
               @lesson ? @lesson.words : Word.all
             else
               @lesson
                 .words
                 .with_learned_by(current_user)
             end

    respond_to do |format|
      format.html
      format.json{render json: @words}
    end
  end

  def destroy
    if @word.destroy
      message_type = :success
      message = t ".success"
    else
      message_type = :error
      message = t ".error"
    end
    respond_to do |format|
      format.html do
        flash[message_type] = message
        redirect_back fallback_location: admin_root_path
      end
      format.json do
        if message_type == :success
          render json: {message: message}
        else
          render json: {message: message}, status: :unprocessable_entity
        end
      end
    end
  end

  def lesson_params
    params.require(:lesson).permit Lesson::UPDATEDB_ATTRS
  end

  private

  def load_word
    @word = Word.find_by id: params[:id]
    return if @word.present?

    flash[:error] = t "words.not_found"
    redirect_to root_path
  end
end

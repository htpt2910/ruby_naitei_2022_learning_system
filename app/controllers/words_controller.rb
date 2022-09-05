class WordsController < ApplicationController
  before_action :load_lesson, only: %i(index show)
  load_and_authorize_resource param_method: :word_params

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

  def load_lesson
    @lesson = Lesson.find_by id: params[:lesson_id]
    return if @lesson

    flash[:error] = t "lessons.lesson_not_found"
    redirect_to root_path
  end

  private

  def word_params
    params.require(:word).permit Word::WORD_ATTRS
  end
end

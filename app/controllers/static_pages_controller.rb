class StaticPagesController < ApplicationController
  def home
    @search_query = current_user.learning_courses.ransack params[:q]
    @pagy, @courses = pagy @search_query.result
  end

  def help; end

  def about; end
end

# frozen_string_literal: true

class Admin::WordsListComponent < ViewComponent::Base
  include Devise::Controllers::Helpers

  def initialize lesson:
    super
    @lesson = lesson
  end

  def table_headers
    headers = [t(".definition"), t(".translation")]
    headers << if current_user.admin?
                 t(".delete")
               else
                 t(".done")
               end
  end

  def table_columns
    columns = %w(definition translation)
    columns << if current_user.admin?
                 "delete"
               else
                 "done"
               end
  end

  def table_data_url
    lesson_words_path @lesson
  end
end

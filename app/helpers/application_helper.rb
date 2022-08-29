module ApplicationHelper
  include Pagy::Frontend
  def full_title page_title = ""
    base_title = t "helper.title"
    page_title.blank? ? base_title : "#{page_title} | #{base_title}"
  end

  def toastr_flash type
    case type
    when "error"
      "toastr.error"
    when "success", "notice"
      "toastr.success"
    when "warning", "alert"
      "toastr.warning"
    else
      "toastr.info"
    end
  end

  def check_error object, attribute
    return if object.errors.nil?

    return "border-danger" if object.errors[attribute].present?
  end
end

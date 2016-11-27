module ApplicationHelper
  def alert_class_for_flash_type(flash_type)
    {
      success: 'alert-success',
      error: 'alert-danger',
      alert: 'alert-danger',
      notice: 'alert-info'
    }[flash_type.to_sym] || flash_type.to_s
  end
end

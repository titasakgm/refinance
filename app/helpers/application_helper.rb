# encoding: utf-8

module ApplicationHelper

  # Add 20171017

  def fullname
    current_user.email.split('@').first + ' ' + office_name
  end


  # Add 20171017

  def office_name
    hc5 = current_user.email.split('@').last
    offname = Admin.find_by_hcode5(hc5).offname
  end

  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type.to_sym] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} fade in") do 
              concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
              concat message 
            end)
    end
    nil
  end

  def custom_message(msg)
    if msg =~ /กรุณา/
      type = 'info'
    elsif msg =~ /ยัง/
      type = 'warning'
    elsif msg =~ /ขออภัย/
      type = 'danger'
    else
      type = 'success'
    end
    type
  end

end

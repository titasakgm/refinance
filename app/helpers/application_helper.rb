module ApplicationHelper
  def office_name
    current_user.email.split('@').last
  end
end

module AdminHelper
  def admin?
    answer = false
    if current_user == nil
      answer = false
    else
      answer = current_user.is_admin
    end
    answer
  end
end

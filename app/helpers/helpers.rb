module Helper
  def current_dev
    @current_dev ||= Developer.find_by_id(session[:id])
  end

  def current_np
    @current_np ||= Nonprofit.find_by_id(session[:id])
  end

  def logged_in?
    !!session[:id]
  end
end
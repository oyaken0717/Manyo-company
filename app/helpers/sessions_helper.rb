module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def authenticate_session_user
    if !self.logged_in?
      redirect_to new_session_path, notice: "ログインしてください"
    end
  end
end

# def hidden_field_tag(params, value: 0, set: '', class: '')
# end

# hidden_field_tag('task', class: 'task_path', value:  )

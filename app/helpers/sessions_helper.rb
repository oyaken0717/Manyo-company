module SessionsHelper
  def current_user
    # 1
    if @current_user.nil?
       @current_user =  User.find_by(id: session[:user_id])
    else
       @current_user =  @current_user
    end
    # 2
    @current_user = @current_user.nil? ? User.find_by(id: session[:user_id]) : @current_user
    # 3
    @current_user = @current_user || User.find_by(id: session[:user_id])
                               # ↑あったらそのまま＠ーを入れる
    # 4
    # n = n + 1
    # n += 1
    @current_user ||= User.find_by(id: session[:user_id])
# 　　　　　　　　　↑あったらそのまま＠ーを入れる
    #　おまけ1 条件と代入したいインスタンスが異なる
    # @tasks =  @current_user.nil? ? User.find_by(id: session[:user_id]).tasks : @current_user.taks

    #　おまけ2 条件が存在するかUserではない
    @current_user = User.all.length > 2 ? User.find_by(id: session[:user_id]) : nil;

  end

  def logged_in?
    current_user.present?
  end

  def authenticate_session_user
    if current_user == nil
      redirect_to new_session_path, notice: "ログインしてください"
    end
  end
end

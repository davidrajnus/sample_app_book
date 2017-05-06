module SessionsHelper

  def log_in(user)
    #this method assigns a ssession to the user signing in
    session[:user_id] = user.id
  end

  def current_user
    #this creates the variable current_user with the signed in user for other uses
    @current_user ||= User.find_by(id: session[:user_id])
    #the convention  ||= equates to @current_user equals to 
    #@current_user or User.find_by. This way it only does the find_by
    #if @current_user is already nil, not all the time someone logs in
  end

  def logged_in?
    @current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

end

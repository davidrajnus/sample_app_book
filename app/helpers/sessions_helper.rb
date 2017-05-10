module SessionsHelper

  def log_in(user)
    #this method assigns a ssession to the user signing in
    session[:user_id] = user.id
  end

  # Remembers a user in a persistent session.
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # def current_user
  #   #this creates the variable current_user with the signed in user for other uses
  #   @current_user ||= User.find_by(id: session[:user_id])
  #   #the convention  ||= equates to @current_user equals to 
  #   #@current_user or User.find_by. This way it only does the find_by
  #   #if @current_user is already nil, not all the time someone logs in
  # end

  # Returns the user corresponding to the remember token cookie.

  def current_user?(user)
      user == current_user
    end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  #redirect to stored location (or to default)
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  #stores the URL trying to be accessed
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

end

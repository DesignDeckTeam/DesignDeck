class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def designer_required
    if !current_user.designer?
      redirect_to "/"
    end
  end
end

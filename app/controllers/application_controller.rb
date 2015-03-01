class ApplicationController < ActionController::Base
  protect_from_forgery

  ## This filter method is used to fetch current user
  before_filter :stylesheet_filename, :javascript_filename, :current_user, :set_default_title

  private

  def set_default_title
    set_title("Q-Projects")
  end

  def stylesheet_filename
    @stylesheet_filename = "application"
  end

  def javascript_filename
    @javascript_filename = "application"
  end

end

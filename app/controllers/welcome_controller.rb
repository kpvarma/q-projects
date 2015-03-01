class WelcomeController < ApplicationController

  layout 'poodle/public'
  before_filter :set_navs

  def home
  end

  private

  def set_navs
    set_nav("Home")
  end

end

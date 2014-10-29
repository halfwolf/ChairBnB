class StaticController < ApplicationController
  
  before_action :require_user!, only: [:dashboard]

  def dashboard
  end
end

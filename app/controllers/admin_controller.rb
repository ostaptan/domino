class AdminController < ApplicationController

  before_filter :authorize_access, :except => [:logout]

  def index

  end

end
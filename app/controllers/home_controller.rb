class HomeController < ApplicationController
	skip_before_filter :authenticate_request!

  def index
  end
end

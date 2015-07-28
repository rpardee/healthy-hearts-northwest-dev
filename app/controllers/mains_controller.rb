class MainsController < ApplicationController

  # GET /mains
  def index
  	@test_partner = Partner.second
  end

end

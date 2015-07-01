class MainsController < ApplicationController

  # GET /mains
  def index
  	@test_partner = Partner.first
  end

end

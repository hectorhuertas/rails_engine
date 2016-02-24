class Api::V1::Items::RandomController < Api::ApiController
  respond_to :json

  def show
    respond_with Item.offset(rand(Item.count)).first
  end
end

class Api::V1::CustomersController < Api::ApiController
  def index
    render json: Customer.all
  end

  def show
    render json: Customer.find(params[:id])
  end
end

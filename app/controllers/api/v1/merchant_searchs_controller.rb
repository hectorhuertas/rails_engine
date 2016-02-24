class Api::V1::MerchantSearchsController < Api::ApiController
  def index
    render json: search_by(attribute)
  end

  def show
    render json: search_by(attribute).first
  end

  private

    def attribute
      params.keys.first
    end

    def search_by(attribute)
      case attribute
      when 'controller' then Merchant.offset(rand(Merchant.count))
      when 'format'     then Merchant.offset(rand(Merchant.count))
      when 'id'         then Merchant.where(id: params[attribute])
      when 'created_at' then Merchant.where(created_at: DateTime.parse(params[attribute]))
      when 'updated_at' then Merchant.where(created_at: DateTime.parse(params[attribute]))
      else                   Merchant.where("#{attribute} ilike ?", params[attribute])
      end
    end
end

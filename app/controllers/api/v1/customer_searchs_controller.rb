class Api::V1::CustomerSearchsController < Api::ApiController
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
      when 'format'     then Customer.offset(rand(Customer.count))
      when 'id'         then Customer.where(id: params[attribute])
      when 'created_at' then Customer.where(created_at: DateTime.parse(params[attribute]))
      when 'updated_at' then Customer.where(created_at: DateTime.parse(params[attribute]))
      else                   Customer.where("#{attribute} ilike ?", params[attribute])
      end
    end
end

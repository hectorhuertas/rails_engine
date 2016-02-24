module DateSearch
  def self.at(params)
    case
    when params[:created_at] then {created_at: DateTime.parse(params[:created_at])}
    when params[:updated_at] then {updated_at: DateTime.parse(params[:updated_at])}
    end
  end
end

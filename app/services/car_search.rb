class CarSearch
  SORT_OPTIONS = %w[price date_added].freeze
  SORT_DIRECTIONS = %w[asc desc].freeze

  def initialize(scope, params)
    @scope = scope
    @params = params
  end

  def call
    filtered = apply_filters(@scope)
    apply_sorting(filtered)
  end

  private

  def apply_filters(scope)
    scope = scope.where("LOWER(make) = ?", @params[:make].downcase) if @params[:make].present?
    scope = scope.where("LOWER(model) = ?", @params[:model].downcase) if @params[:model].present?
    scope = scope.where("year >= ?", @params[:year_from]) if @params[:year_from].present?
    scope = scope.where("year <= ?", @params[:year_to]) if @params[:year_to].present?
    scope = scope.where("price >= ?", @params[:price_from]) if @params[:price_from].present?
    scope = scope.where("price <= ?", @params[:price_to]) if @params[:price_to].present?
    scope = scope.where("odometer >= ?", @params[:odometer_from]) if @params[:odometer_from].present?
    scope = scope.where("odometer <= ?", @params[:odometer_to]) if @params[:odometer_to].present?

    scope
  end

  def apply_sorting(scope)
    sort_option = SORT_OPTIONS.include?(@params[:sort]) ? @params[:sort] : "date_added"
    direction   = SORT_DIRECTIONS.include?(@params[:direction]) ? @params[:direction] : "desc"

    scope.order(sort_option => direction)
  end
end

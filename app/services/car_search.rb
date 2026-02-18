class CarSearch
  SORT_OPTIONS    = %w[price date_added].freeze
  SORT_DIRECTIONS = %w[asc desc].freeze
  DEFAULT_SORT    = "date_added"
  DEFAULT_DIR     = "desc"

  def initialize(scope, params)
    @scope  = scope
    @params = params
  end

  def call
    apply_sorting(apply_filters(@scope))
  end

  private

  def apply_filters(scope)
    scope = scope.where(make: @params[:make]) if present?(:make)
    scope = scope.where(model: @params[:model]) if present?(:model)

    scope = scope.where("year >= ?", @params[:year_from]) if present?(:year_from)
    scope = scope.where("year <= ?", @params[:year_to]) if present?(:year_to)

    scope = scope.where("price >= ?", @params[:price_from]) if present?(:price_from)
    scope = scope.where("price <= ?", @params[:price_to]) if present?(:price_to)

    scope = scope.where("odometer >= ?", @params[:odometer_from]) if present?(:odometer_from)
    scope = scope.where("odometer <= ?", @params[:odometer_to]) if present?(:odometer_to)

    scope
  end

  def apply_sorting(scope)
    sort      = SORT_OPTIONS.include?(@params[:sort]) ? @params[:sort] : DEFAULT_SORT
    direction = SORT_DIRECTIONS.include?(@params[:direction]) ? @params[:direction] : DEFAULT_DIR

    scope.order(sort => direction)
  end

  def present?(key)
    @params[key].present?
  end
end

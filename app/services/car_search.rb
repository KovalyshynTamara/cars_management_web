class CarSearch
  SORT_OPTIONS    = %w[price date_added].freeze
  SORT_DIRECTIONS = %w[asc desc].freeze
  DEFAULT_SORT    = "date_added"
  DEFAULT_DIR     = "desc"

  def initialize(scope = Car.all, params = {})
    @scope = scope

    @params =
      if params.respond_to?(:permit!)
        params.permit!.to_h.symbolize_keys
      else
        params.to_h.symbolize_keys
      end
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
    sort, direction = extract_sorting
    scope.order(sort => direction.to_sym)
  end

  def extract_sorting
    if @params[:sorting].present?
      sort, direction = @params[:sorting].split("_")
    else
      sort = @params[:sort]
      direction = @params[:direction]
    end

    sort = SORT_OPTIONS.include?(sort) ? sort : DEFAULT_SORT
    direction = SORT_DIRECTIONS.include?(direction) ? direction : DEFAULT_DIR

    [ sort, direction ]
  end

  def present?(key)
    @params[key].present?
  end
end

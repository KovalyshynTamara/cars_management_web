class SearchStatisticsService
  def initialize(user:, rules:, total_quantity:)
    @user           = user
    @rules          = rules
    @total_quantity = total_quantity
  end

  def call
    search = @user.searches.find_or_initialize_by(rules: @rules)

    search.with_lock do
      search.requests_quantity = search.requests_quantity.to_i + 1
      search.total_quantity    = @total_quantity
      search.save!
    end

    search
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error("Search statistics failed: #{e.message}")
    nil
  end
end

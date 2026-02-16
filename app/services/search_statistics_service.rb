class SearchStatisticsService
  def initialize(user, rules, total_quantity)
    @user = user
    @rules = rules
    @total_quantity = total_quantity
  end

  def call
    search = @user.searches.find_or_initialize_by(rules: @rules)

    search.requests_quantity ||= 0
    search.requests_quantity += 1
    search.total_quantity = @total_quantity

    search.save!
    search
  end
end

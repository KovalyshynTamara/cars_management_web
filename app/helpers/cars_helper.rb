module CarsHelper
  def sorting_options
    [
      [ t("cars.sorting.price_asc"),  "price_asc" ],
      [ t("cars.sorting.price_desc"), "price_desc" ],
      [ t("cars.sorting.date_desc"),  "date_desc" ],
      [ t("cars.sorting.date_asc"),   "date_asc" ]
    ]
  end

  def selected_sorting
    "#{params[:sort] || 'date_added'}_#{params[:direction] || 'desc'}"
  end
end

module CarsHelper
  def sorting_options
    [
      [ "Price: Low to High",  "price_asc" ],
      [ "Price: High to Low",  "price_desc" ],
      [ "Date: Most Recent",   "date_desc" ],
      [ "Date: Oldest First",  "date_asc" ]
    ]
  end

  def selected_sorting
    "#{params[:sort] || 'date'}_#{params[:direction] || 'desc'}"
  end
end

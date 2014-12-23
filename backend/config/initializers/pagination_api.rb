class WillPaginate::Collection
  def as_json(params = {})
    {page: current_page,
      per_page: per_page,
      total: count,
      items: super}
  end
end

class User < ActiveRecord::Base
  has_many :posts

  def top_posts
    posts.order(:created_at).reverse_order.limit(3)
  end

  def as_json(params = {})
    super params.merge(include: {top_posts: {only: [:id, :text]}
                       })
  end
end

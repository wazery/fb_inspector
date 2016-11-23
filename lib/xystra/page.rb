module Xystra
  class Page
    attr_accessor :id, :posts, :posts_limit

    def initialize(id, post_limit)
      @id          = id
      @posts_limit = post_limit
      @posts       = posts
    end

    def posts
      # memoized posts, so we don't disable the accessor, this can be also changed
      # to a private method with another name instead and remove this
      return @posts if defined? @posts

      posts = GraphApi.instance.get_connections(id, 'feed', limit: @posts_limit, fields: %w(type parent_id))

      posts.map do |post|
        Post.new(post['id'], post['type'], @id, post['parent_id'])
      end
    end

    def as_json(options = {})
      posts
    end

    def to_json(*options)
      as_json(*options).to_json(*options)
    end

    def as_csv
      posts
    end

    def to_csv
      as_csv.to_csv
    end
  end
end

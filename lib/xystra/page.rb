module Xystra
  class Page
    attr_accessor :id, :posts, :posts_limit

    def initialize(id, post_limit)
      @id          = id
      @posts_limit = post_limit
      @posts       = posts
    end

    def posts
      return @posts if defined? @posts # memoized posts

      posts = GraphApi.instance.get_connections(id, 'feed', limit: @post_limit, fields: ['type', 'parent_id'])

      posts.map do |post|
        Post.new(post['id'], post['type'], @id, post['parent_id'])
      end
    end

    def as_json(options = {})
      {
      }
    end

    def to_json(*options)
      as_json(*options).to_json(*options)
    end

    def to_csv
      byebug
    end
  end
end

require 'fb/inspector/version'
require 'koala'

module Fb
  module Inspector
    class Interactions
      def initialize(page_ids, posts_limit)
        @page_ids    = page_ids.delete_if(&:blank?)
        @posts_limit = posts_limit.delete_if(&:blank?)
      end

      def get_interactions
        @graph = Koala::Facebook::API.new(ENV['GRAPH_API_ACCESS_TOKEN'], ENV['GRAPH_API_APP_SECRET'])
        interactions_arr = []

        @page_ids.each_with_index do |page_id, index|
          page_feed = @graph.get_connections(page_id, 'feed', limit: @posts_limit[index])

          page_feed.each do |post|
            reactions = @graph.get_connections(post['id'], 'reactions')
            reactions.each do |reaction|
              interactions_arr.push(user_id: reaction['id'], page_id: page_id, post_id: post['id'],
                                    post_type: post['type'], interaction_type: 'reaction',
                                    interaction_sub_type: reaction['type'])
            end

            comments = @graph.get_connections(post['id'], 'comments')
            comments.each do |comment|
              interactions_arr.push(user_id: comment['from']['id'], page_id: page_id,
                                    post_id: post['id'], post_type: post['type'],
                                    interaction_type: 'comment', interaction_sub_type: '')
            end
          end
        end

        interactions_arr
      end
    end
  end
end

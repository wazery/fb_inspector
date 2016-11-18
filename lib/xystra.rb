require 'xystra/version'
require 'xystra/dependencies'
require 'xystra/configuration'
require 'xystra/graph_api'
require 'xystra/page'
require 'xystra/post'
require 'xystra/post_action'
require 'xystra/reaction'
require 'xystra/comment'
require 'xystra/tag'

module Xystra
  # TODO: Implement to_csv method
  # user_id, page_id, post_id, post_type, interaction_type, [interaction_sub_type, person_tagged_id, person_tagged_name]
  class Interactions
    def initialize(page_ids, posts_limit)
      @page_ids    = page_ids.delete_if(&:blank?)
      @posts_limit = posts_limit.delete_if(&:blank?)
    end

    def interactions
      @page_ids.each_with_index.map do |page_id, index|
        Page.new(page_id, @posts_limit[index])
      end
    end

    # def get_interactions
    #   interactions_arr = []
    #
    #   @page_ids.each_with_index do |page_id, index|
    #     page_feed = GraphApi.instance.get_connections(page_id, 'feed', limit: @posts_limit[index], fields: ['type', 'parent_id'])
    #     byebug
    #
    #     page_feed.each do |post|
    #       reactions = GraphApi.instance.get_connections(post['id'], 'reactions')
    #       reactions.each do |reaction|
    #         interactions_arr.push(user_id: reaction['id'], page_id: page_id, post_id: post['id'],
    #                               post_type: post['type'], interaction_type: 'reaction',
    #                               interaction_sub_type: reaction['type'])
    #       end
    #
    #       comments = GraphApi.instance.get_connections(post['id'], 'comments')
    #       comments.each do |comment|
    #         interactions_arr.push(user_id: comment['from']['id'], page_id: page_id,
    #                               post_id: post['id'], post_type: post['type'],
    #                               interaction_type: 'comment', interaction_sub_type: '')
    #       end
    #
    #       if post['type'] == 'photo'
    #         tags = GraphApi.instance.get_object(post['parent_id'], fields: 'with_tags') if post['parent_id']
    #         if tags && tags['with_tags'].present?
    #           tags['with_tags']['data'].each do |tag|
    #             interactions_arr.push(user_id: tag['id'], page_id: page_id, post_id: post['id'], post_type: 'photo', interaction_type: 'tag', person_tagged_name: tag['name'])
    #           end
    #         end
    #       end
    #     end
    #   end
    #
    #   interactions_arr
    # end
  end
end

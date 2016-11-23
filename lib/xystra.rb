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
  class Interactions
    attr_accessor :pages

    def initialize(page_ids, posts_limit)
      @page_ids    = page_ids.delete_if(&:blank?)
      @posts_limit = posts_limit.delete_if(&:blank?)
      @pages       = interactions
    end

    def to_json(options = {})
      pages.to_json
    end

    def to_csv
      attributes.join(',') + "\n" + pages.to_csv
    end

    private

    def interactions
      @page_ids.each_with_index.map do |page_id, index|
        Page.new(page_id, @posts_limit[index])
      end
    end

    def attributes
      %w(user_id page_id post_id post_type interaction_type interaction_sub_type person_tagged_name)
    end
  end
end

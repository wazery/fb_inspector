module Xystra
  class Tag < PostAction
    attr_accessor :person_tagged_name

    def initialize(page_id, user_id, post_id, post_type, person_tagged_name)
      @page_id              = page_id
      @user_id              = user_id
      @post_id              = post_id
      @post_type            = post_type
      @interaction_type     = 'tag'
      @person_tagged_name   = person_tagged_name
    end

    def as_json(options = {})
      {
        user_id: @user_id,
        page_id: @page_id,
        post_id: @post_id,
        post_type: @post_type,
        interaction_type: @interaction_type,
        person_tagged_name: @person_tagged_name
      }
    end

    def to_json(*options)
      as_json(*options).to_json(*options)
    end

    def as_csv(options = nil)
      "#{@page_id},#{@user_id},#{@post_id},#{@post_type},#{@interaction_type},#{@person_tagged_name}"
    end

    def to_csv
      as_csv
    end
  end
end

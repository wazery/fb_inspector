module Xystra
  class Tag < PostAction
    attr_accessor :person_tagged_name

    def initialize(page_id, user_id, person_tagged_name)
      @page_id              = page_id
      @user_id              = user_id
      @interaction_type     = 'tag'
      @interaction_sub_type = nil
      @person_tagged_name   = person_tagged_name
    end

    def to_csv
    end
  end
end

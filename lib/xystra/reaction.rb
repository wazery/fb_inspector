module Xystra
  class Reaction < PostAction
    attr_accessor :interaction_sub_type

    def initialize(page_id, user_id, interaction_sub_type)
      @page_id              = page_id
      @user_id              = user_id
      @interaction_type     = 'reaction'
      @interaction_sub_type = interaction_sub_type
    end

    def to_csv
    end
  end
end

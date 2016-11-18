module Xystra
  class Comment < PostAction
    def initialize(page_id, user_id)
      @page_id          = page_id
      @user_id          = user_id
      @interaction_type = 'comment'
    end

    def to_csv
    end
  end
end

module Xystra
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    # The Facebook Graph API access token
    # @return [String]
    attr_accessor :graph_api_token

    # The Facebook Graph API app secret
    # @return [String]
    attr_accessor:graph_api_secret

    # This is set to nil to make it clear that the gem don't provide
    # the values initially, and user needs to do so.
    def initialize
      @graph_api_token  = nil
      @graph_api_secret = nil
    end
  end
end

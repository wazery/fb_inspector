class GraphApi
  include Singleton

  def initialize
    @graph = Koala::Facebook::API.new(Xystra.configuration.graph_api_token,
                                      Xystra.configuration.graph_api_secret)
  end

  # Delegate the applicable methods to the FB Graph API instance
  def method_missing(method, *args)
    if @graph.respond_to?(method)
      @graph.send(method, *args)
    else
      super
    end
  end
end

module Jetter
  class Client
    class Fullfillment
      def initialize(client)
        @client = client
      end

      def get_nodes
        @client.rest_get_with_token("/fulfillment-nodes")
      end

      def get_node(node_url)
        @client.rest_get_with_token(node_url)
      end
    end
  end
end

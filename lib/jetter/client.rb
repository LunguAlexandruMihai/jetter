require 'rest-client'
require 'oj'

module Jetter
  class Client
    API_URL = 'https://merchant-api.jet.com/api'.freeze

    def initialize(config = {}, raw_token = {})
      @api_user = config[:api_user]
      @secret = config[:api_secret]
      @merchant_id = config[:api_merchant]
      @id_token = raw_token[:id_token]
      @token_type = raw_token[:token_type]
      @expires_on = Time.parse(raw_token[:expires_on].to_s) if raw_token[:expires_on]
    end

    def encode_json(data)
      Oj.dump(data, mode: :compat)
    end

    def decode_json(json)
      Oj.load(json)
    end

    def generate_token
      unless token_valid?
        body = { user: @api_user, pass: @secret }
        response = RestClient.post("#{API_URL}/token", encode_json(body))
        parsed_response = decode_json(response.body)
        @id_token = parsed_response['id_token']
        @token_type = parsed_response['token_type']
        @expires_on = Time.parse(parsed_response['expires_on'])
      end
      raw_token
    end

    def token
      generate_token unless token_valid?
      { Authorization: "#{@token_type} #{@id_token}" }
    end

    def raw_token
      if token_valid?
        {
          id_token: @id_token,
          token_type: @token_type,
          expires_on: @expires_on.iso8601
        }
      else
        {}
      end
    end

    def token_valid?
      @id_token && @token_type && @expires_on > Time.now
    end

    def rest_get_with_token(path, query_params = {})
      headers = token
      headers[:params] = query_params unless query_params.empty?
      response = RestClient.get("#{API_URL}#{path}", headers)
      payload = ''
      payload = decode_json(response.body) if response.code >= 200 && response.code < 300
      {code: response.code, response: response, payload: payload}
    rescue => e
      {exception: e.class, response: e }
    end

    def rest_put_with_token(path, body = {})
      headers = token
      response = RestClient.put("#{API_URL}#{path}", encode_json(body), headers)
      payload = ''
      payload = decode_json(response.body) if response.code >= 200 && response.code < 300
      {code: response.code, payload: payload}
    rescue => e
      {exception: e.class, response: e }
    end

    def rest_post_with_token(path, body = {})
      headers = token
      response = RestClient.post("#{API_URL}#{path}", encode_json(body), headers)
      payload = ''
      payload = decode_json(response.body) if response.code >= 200 && response.code < 300
      {code: response.code, payload: payload}
    rescue => e
      {exception: e.class, response: e }
    end

    def rest_patch_with_token(path, body = {})
      headers = token
      response = RestClient.patch("#{API_URL}#{path}", encode_json(body), headers)
      payload = ''
      payload = decode_json(response.body) if response.code >= 200 && response.code < 300
      {code: response.code, payload: payload}
    rescue => e
      {exception: e.class, response: e }
    end

    def orders
      Orders.new(self)
    end

    def returns
      Returns.new(self)
    end

    def products
      Products.new(self)
    end

    def taxonomy
      Taxonomy.new(self)
    end

    def files
      Files.new(self)
    end

    def refunds
      Refunds.new(self)
    end

    def fullfillment
      Fullfillment.new(self)
    end
  end
end

require 'jetter/client/orders'
require 'jetter/client/products'
require 'jetter/client/taxonomy'
require 'jetter/client/files'
require 'jetter/client/refunds'
require 'jetter/client/returns'
require 'jetter/client/fullfillment'
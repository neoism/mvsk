require 'securerandom'

module Papago
  class OpenAIService
    attr_reader :name

    def initialize(api_key: nil, config:)
      @endpoint = config.fetch('openai.endpoint')
      @token = api_key || ENV['OPENAI_FANYI_API_KEY']

      @config = config
      @name = :openai
    end

    def call(text:, user: nil)
      user ||= generate_user_id
      require 'http' unless defined?(HTTP)

      response = HTTP
        .auth("Token #{@token}")
        .post(@endpoint, json: { prompt: text, user: user })

      JSON.parse(response.body)
    end

    private

    def generate_user_id
      @user_id ||= @config.fetch('user_id')

      if @user_id.nil?
        @user_id = SecureRandom.hex

        @config.set('user_id', value: @user_id)
        @config.write(force: true)
      end

      @user_id
    end
  end
end

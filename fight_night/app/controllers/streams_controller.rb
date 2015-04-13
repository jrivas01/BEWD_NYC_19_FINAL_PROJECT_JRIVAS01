require 'json'
require 'rest-client'
require 'uri'

class StreamsController < ApplicationController
    def index
        @games = Game.all
    end

    def initialize (name)
        @name = name
        
        api_url = URI.escape("https://api.twitch.tv/kraken/search/streams?q=#{@name}")
        
        raw_output = RestClient.get(api_url)

        @channels = JSON.load(raw_output)["streams"]
    end

    def print_channels
        @channels.each do |index|
            puts index["channel"]["status"]
            puts index["channel"]["url"]
        end
    end

    def game_name #gets the "proper" name of the from the data we retrived from the API
        @channels[0]["game"]
    end
end

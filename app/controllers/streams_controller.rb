class StreamsController < ApplicationController
    def index
        @twitch_streams = []
        @hitbox_streams =[]
        twitch = Twitch.new

        Game.all.each do | game |
            raw_output = twitch.searchStreams({q:"#{game.name}"})
            if raw_output[:body]["streams"].empty? then 
                next 
            end
            @twitch_streams.push(raw_output[:body]["streams"])
        end

        Game.all.each do | game |
            raw_output = HitboxHelper.streams("#{game.name}")
            if raw_output.empty? then 
                next 
            end
            @hitbox_streams.push(raw_output)
        end

    end

    def show
        @twitch_streams = []
        @hitbox_streams =[]
        twitch = Twitch.new

        raw_output = twitch.searchStreams({q: params[:id]})

        @twitch_streams.push(raw_output[:body]["streams"])

        raw_output = HitboxHelper.streams(params[:id])

        @hitbox_streams.push(raw_output)
    end

    def twitch
        @twitch = Twitch.new
        raw_output = Twitch.new.searchStreams({q:"#{params[:id]}"})
        @channel = raw_output[:body]["streams"][0]["channel"]
    end

    def hitbox
        @channel = params[:id]
    end

end

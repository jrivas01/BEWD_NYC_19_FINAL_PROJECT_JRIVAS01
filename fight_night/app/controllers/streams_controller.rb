class StreamsController < ApplicationController
    def index
        @twitch_streams = []
        @hitbox_streams =[]
        @twitch = Twitch.new

        Game.all.each do | game |
            raw_output = @twitch.searchStreams({q:"#{game.name}"})
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

        #@hitbox_streams.push(HitboxHelper.streams("League of Legends"))
    end
end

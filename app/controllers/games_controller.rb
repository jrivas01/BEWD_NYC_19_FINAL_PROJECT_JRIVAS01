class GamesController < ApplicationController

  def index
    @games = Game.all
    @boxart = []

    Game.all.each do | game |
      raw_output = Twitch.new.searchGames({q:"#{game.name}", type: "suggest"})
        if raw_output[:body]["games"].empty? then 
          next 
        end
      @boxart.push(raw_output[:body]["games"][0])
    end

  end

  def show
    @game = Game.find(params[:id])
    @boxart = []
    raw_output = Twitch.new.searchGames({q:"#{@game.name}", type: "suggest"})
    @boxart.push(raw_output[:body]["games"][0])
  end

  def new
      @game = Game.new(:name => params[:new_game])
  end

  def create
    name = params[:game][:name]

    @game = Game.new(name: name)

    if @game.save
        redirect_to @game
    else
        render "new"
    end
  end

  def edit
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    @game.update(name: params[:game][:name])

    redirect_to @game
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    redirect_to games_path, notice: 'Game removed'
  end

  def search
    raw_output = Twitch.new.searchGames({q:"#{params[:q]}", type: "suggest"})
    @search_result = raw_output[:body]["games"]
  end

end

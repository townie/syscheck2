require 'sinatra'
require 'shotgun'

#Increased data set to make sure things were working properly on larger data sets as well as small sample size
#Discovered that needed to create new custom sorting ranking
#Bootstrapped to make look nice

def load_stats
[
  {
    home_team: "Jets",
    away_team: "Giants",
    home_score: 21,
    away_score: 3
  },
  {
    home_team: "Steelers",
    away_team: "Giants",
    home_score: 21,
    away_score: 3
  },
  {
    home_team: "Patriots",
    away_team: "Giants",
    home_score: 21,
    away_score: 3
  },
  {
    home_team: "Chargers",
    away_team: "Jets",
    home_score: 13,
    away_score: 6
  },
  {
    home_team: "Patriots",
    away_team: "Jets",
    home_score: 13,
    away_score: 6
  },
   {
    home_team: "Steelers",
    away_team: "Jets",
    home_score: 3,
    away_score: 6
  },
  {
    home_team: "Dolphins",
    away_team: "Jets",
    home_score: 0,
    away_score: 3
  },
{
    home_team: "Browns",
    away_team: "Jets",
    home_score: 0,
    away_score: 21
  },
  {
    home_team: "Chargers",
    away_team: "Jets",
    home_score: 7,
    away_score: 21
  },
   {
    home_team: "Steelers",
    away_team: "Broncos",
    home_score: 7,
    away_score: 13
  },
  {
    home_team: "Patriots",
    away_team: "Broncos",
    home_score: 7,
    away_score: 3
  },
  {
    home_team: "Broncos",
    away_team: "Colts",
    home_score: 3,
    away_score: 0
  },
  {
    home_team: "Patriots",
    away_team: "Colts",
    home_score: 11,
    away_score: 7
  },
  {
    home_team: "Steelers",
    away_team: "Patriots",
    home_score: 7,
    away_score: 21
  },
  {
    home_team: "Steelers",
    away_team: "Colts",
    home_score: 24,
    away_score: 21
  },
  {
    home_team: "Steelers",
    away_team: "Colts",
    home_score: 24,
    away_score: 21
  }
]
end

def create_team_records
  records = {}
  @stats.each do |game|
    #START THE SEASON OUT ALL ZERO'D OUT
    if  !(records.has_key?(game[:home_team]))
      records[game[:home_team]] ={win: 0, lose: 0, pf: 0, pa: 0}
    end
    if  !(records.has_key?(game[:away_team]))
      records[game[:away_team]] ={win: 0, lose: 0, pf: 0, pa: 0}
    end

    #UPDATE WINNERS AND LOSERS DATA COLUMS
    if game[:home_score] > game[:away_score]
      home_team = records[game[:home_team]]
      away_team = records[game[:away_team]]
      home_team[:win] = home_team[:win] + 1
      home_team[:pa] = home_team[:pa] + game[:away_score]
      home_team[:pf] = home_team[:pf] + game[:home_score]
      away_team[:lose] = away_team[:lose] + 1
      away_team[:pa] = away_team[:pa] + game[:home_score]
      away_team[:pf] = away_team[:pf] + game[:away_score]
     end

     if game[:home_score] < game[:away_score]
      home_team = records[game[:home_team]]
      away_team = records[game[:away_team]]
      home_team[:lose] = home_team[:lose] + 1
      home_team[:pa] = home_team[:pa] + game[:away_score]
      home_team[:pf] = home_team[:pf] + game[:home_score]
      away_team[:win] = away_team[:win] + 1
      away_team[:pa] = away_team[:pa] + game[:home_score]
      away_team[:pf] = away_team[:pf] + game[:away_score]
     end

    #SORT BY WINS THEN SORT BY LOSES SO HIGHEST WINS AT TOP AND MOST LOSES AT BOTTOM
  end
  # records = records.sort_by {|team, stats| stats[:lose]  }
  records
end

def rank_teams(team_stats)
  #clever sorting! weighted wins vs loses
  team_stats.sort_by{|team, stat| stat[:win] + (stat[:win] - stat[:lose]) }.reverse
end

get '/' do
  @stats = load_stats
  @records = create_team_records

  erb :index
end

get '/leaderboard' do
  @stats = load_stats
  @records = rank_teams(create_team_records)

  erb :leaderboard
end


get '/teams/:team' do
  @stats = load_stats
  @records = create_team_records
  @current_team = params[:team]

  erb :teams
end

# These lines can be removed since they are using the default values. They've
# been included to explicitly show the configuration options.
set :views, File.dirname(__FILE__) + '/views'
set :public_folder, File.dirname(__FILE__) + '/public'

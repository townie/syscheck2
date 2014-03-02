@stats = [
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
  }
]



#{team:{win:, lose:, pf:, pa:}}
@records = {}

@stats.each do |game|
  #START THE SEASON OUT ALL ZERO'D OUT
  if  !(@records.has_key?(game[:home_team]))
    @records[game[:home_team]] ={win: 0, lose: 0, pf: 0, pa: 0}
  end
  if  !(@records.has_key?(game[:away_team]))
    @records[game[:away_team]] ={win: 0, lose: 0, pf: 0, pa: 0}
  end

  #UPDATE WINNERS AND LOSERS DATA COLUMS
  if game[:home_score] > game[:away_score]
    @records[game[:home_team]][:win] = @records[game[:home_team]][:win] + 1
    @records[game[:home_team]][:pa] = @records[game[:home_team]][:pa] + game[:away_score]
    @records[game[:home_team]][:pf] = @records[game[:home_team]][:pf] + game[:home_score]
    @records[game[:away_team]][:lose] = @records[game[:away_team]][:lose] + 1
    @records[game[:away_team]][:pa] = @records[game[:away_team]][:pa] + game[:home_score]
    @records[game[:away_team]][:pf] = @records[game[:away_team]][:pf] + game[:away_score]
  end
   if game[:home_score] < game[:away_score]
    @records[game[:home_team]][:lose] = @records[game[:home_team]][:lose] + 1
    @records[game[:home_team]][:pa] = @records[game[:home_team]][:pa] + game[:away_score]
    @records[game[:home_team]][:pf] = @records[game[:home_team]][:pf] + game[:home_score]
    @records[game[:away_team]][:win] = @records[game[:away_team]][:win] + 1
    @records[game[:away_team]][:pa] = @records[game[:away_team]][:pa] + game[:home_score]
    @records[game[:away_team]][:pf] = @records[game[:away_team]][:pf] + game[:away_score]
  end
end
 @records = @records.sort_by {|team, stats| !stats[:win]  }

@records= @records.sort_by {|team, stats| stats[:lose]  }




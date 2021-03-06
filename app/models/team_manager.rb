class TeamManager
  attr_reader :positions, :batting_order, :id, :pitcher, :lineup
  attr_accessor :score

  def initialize(lineup)
    @id = lineup.team_id
    @lineup = lineup
    #for now positions are numeric positions - 1
    @positions = get_positions
    @batting_order = get_batting_order
    @pitcher = lineup.pitcher
  end

  def get_positions
    [lineup.pitcher, lineup.catcher, lineup.first_baseman,
      lineup.second_baseman, lineup.third_baseman, lineup.shortstop,
      lineup.left_fielder, lineup.center_fielder, lineup.right_fielder]
  end

  def get_batting_order
    BattingOrder.new([lineup.first_up, lineup.second_up, lineup.third_up,
      lineup.fourth_up, lineup.fifth_up, lineup.sixth_up,
      lineup.seventh_up, lineup.eighth_up, lineup.ninth_up])
  end
end

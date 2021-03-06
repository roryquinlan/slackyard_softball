require 'rails_helper'

describe Player do
  it 'name concatenates first and last name' do
    player = FactoryGirl.build(:player, first_name: 'Joe', last_name: 'Morgan')

    expect(player.name).to eq 'Joe Morgan'
  end

  it 'calculates player stats, most are starting at zero' do
    player = FactoryGirl.build(:player)

    expect(player.homeruns).to eq 0
    expect(player.triples).to eq 0
    expect(player.doubles).to eq 0
    expect(player.singles).to eq 0
    expect(player.rbis).to eq 0
    expect(player.runs_scored).to eq 0
    expect(player.strikeouts_thrown).to eq 0
    expect(player.wins).to eq 0
    expect(player.losses).to eq 0
    expect(player.err_count).to eq 0
    expect(player.batting_average).to eq 0
    expect(player.field_percentage).to eq 0

  end

  it 'calculates player stats, those with divide-by-zero constraints are predetermined' do
    player = FactoryGirl.build(:player)

    expect(player.era).to eq 999.99
  end

  it 'has a team' do
    player = FactoryGirl.build(:player)

    expect(player.team).to be_instance_of(Team)
  end

  it 'has a league' do
    player = FactoryGirl.build(:player)

    expect(player.team.league).to be_instance_of(League)
  end
end

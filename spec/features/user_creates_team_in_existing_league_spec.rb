require 'rails_helper'

feature "User creates a team in an existing league" do
  # As a user,
  # I want to join a league,
  # so I can be a part of the fun.
  #
  # Acceptance Criteria:
  #
  # * I create a team that persists in the database
  # * I am taken to the league page for the team upon creation

  it "creates a team associated with a league" do

    league = FactoryGirl.create(:league)
    user = FactoryGirl.create(:user)
    team = FactoryGirl.build(:team)

    sign_in_as(user)

    visit league_path(league)

    click_on "Create a new team"

    fill_in "Name", with: team.name

    click_on "Create Team"

    expect(page).to have_content league.name
    expect(page).to have_content team.name
  end

  it "tries to create a team with incomplete info and gets error message" do

    league = FactoryGirl.create(:league)
    user = FactoryGirl.create(:user)
    team = FactoryGirl.build(:team)

    sign_in_as(user)

    visit league_path(league)

    click_on "Create a new team"

    click_on "Create Team"

    expect(page).not_to have_content "Success"
    expect(page).not_to have_content team.name
  end

end

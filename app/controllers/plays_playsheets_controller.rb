class PlaysPlaysheetsController < ApplicationController
  def index
    matching_plays_playsheets = PlaysPlaysheet.all

    @list_of_plays_playsheets = matching_plays_playsheets.order({ :created_at => :desc })

    render({ :template => "plays_playsheet_templates/index" })
  end

def bulk_create
  playsheet = Playsheet.find(params.fetch("playsheet_id"))

  scenario_by_play = params.fetch("scenario_by_play", {}) # { "1550" => "3", "1551" => "" }

  scenario_by_play.each do |play_id, scenario_id|
    next if scenario_id.blank?

    PlaysPlaysheet.find_or_create_by!(
      playsheet_id: playsheet.id,
      play_id: play_id.to_i
    ) do |pp|
      pp.scenario_id = scenario_id.to_i
    end
  end

  redirect_to("/playsheets/#{playsheet.id}", notice: "Plays added to playsheet.")
end


  def show
    the_id = params.fetch("path_id")

    matching_plays_playsheets = PlaysPlaysheet.where({ :id => the_id })

    @the_plays_playsheet = matching_plays_playsheets.at(0)

    render({ :template => "plays_playsheet_templates/show" })
  end

  def create
    the_plays_playsheet = PlaysPlaysheet.new
    the_plays_playsheet.playsheet_id = params.fetch("query_playsheet_id")
    the_plays_playsheet.play_id = params.fetch("query_play_id")

    if the_plays_playsheet.valid?
      the_plays_playsheet.save
      redirect_to("/plays_playsheets", { :notice => "Plays playsheet created successfully." })
    else
      redirect_to("/plays_playsheets", { :alert => the_plays_playsheet.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_plays_playsheet = PlaysPlaysheet.where({ :id => the_id }).at(0)

    the_plays_playsheet.playsheet_id = params.fetch("query_playsheet_id")
    the_plays_playsheet.play_id = params.fetch("query_play_id")

    if the_plays_playsheet.valid?
      the_plays_playsheet.save
      redirect_to("/plays_playsheets/#{the_plays_playsheet.id}", { :notice => "Plays playsheet updated successfully." } )
    else
      redirect_to("/plays_playsheets/#{the_plays_playsheet.id}", { :alert => the_plays_playsheet.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_plays_playsheet = PlaysPlaysheet.where({ :id => the_id }).at(0)

    the_plays_playsheet.destroy

    redirect_to("/plays_playsheets", { :notice => "Plays playsheet deleted successfully." } )
  end
end

class PlaysheetsController < ApplicationController
  def index
    
  @playbooks = Playbook.order(:playbook_name)



    matching_playsheets = Playsheet.all

    @list_of_playsheets = matching_playsheets.order({ :created_at => :desc })

    render({ :template => "playsheet_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_playsheets = Playsheet.where({ :id => the_id })

    @the_playsheet = matching_playsheets.at(0)

    play_ids = PlaysPlaybook.where(:playbook_id => @the_playsheet.playbook_id).select(:play_id)

    @list_of_plays = Play.where(:id => play_ids)

    selected_play_ids = PlaysPlaysheet.where(:playsheet_id => the_id).select(:play_id)

    @selected_plays = Play.where(:id => selected_play_ids)
    render({ :template => "playsheet_templates/show" })
  end

  def create
    @playbooks = Playbook.order(:playbook_name => :asc)
    the_playsheet = Playsheet.new
    the_playsheet.user_id = current_user.id
    the_playsheet.playsheet_name = params.fetch("query_playsheet_name")
    the_playsheet.side_of_ball = params.fetch("query_side_of_ball")
    the_playsheet.playbook_id = params.fetch("query_playbook_id")

    if the_playsheet.valid?
      the_playsheet.save
      redirect_to("/playsheets", { :notice => "Playsheet created successfully." })
    else
      redirect_to("/playsheets", { :alert => the_playsheet.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_playsheet = Playsheet.where({ :id => the_id }).at(0)

    the_playsheet.user_id = params.fetch("query_user_id")
    the_playsheet.playsheet_name = params.fetch("query_playsheet_name")
    the_playsheet.side_of_ball = params.fetch("query_side_of_ball")
    the_playsheet.playbook_id = params.fetch("query_playbook_id")

    if the_playsheet.valid?
      the_playsheet.save
      redirect_to("/playsheets/#{the_playsheet.id}", { :notice => "Playsheet updated successfully." } )
    else
      redirect_to("/playsheets/#{the_playsheet.id}", { :alert => the_playsheet.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_playsheet = Playsheet.where({ :id => the_id }).at(0)

    the_playsheet.destroy

    redirect_to("/playsheets", { :notice => "Playsheet deleted successfully." } )
  end
end

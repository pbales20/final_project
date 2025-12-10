class PlaysPlaybooksController < ApplicationController
  def index
    matching_plays_playbooks = PlaysPlaybook.all

    @list_of_plays_playbooks = matching_plays_playbooks.order({ :created_at => :desc })

    render({ :template => "plays_playbook_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_plays_playbooks = PlaysPlaybook.where({ :id => the_id })

    @the_plays_playbook = matching_plays_playbooks.at(0)

    render({ :template => "plays_playbook_templates/show" })
  end

  def create
    the_plays_playbook = PlaysPlaybook.new
    the_plays_playbook.play_id = params.fetch("query_play_id")
    the_plays_playbook.playbook_id = params.fetch("query_playbook_id")

    if the_plays_playbook.valid?
      the_plays_playbook.save
      redirect_to("/plays_playbooks", { :notice => "Plays playbook created successfully." })
    else
      redirect_to("/plays_playbooks", { :alert => the_plays_playbook.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_plays_playbook = PlaysPlaybook.where({ :id => the_id }).at(0)

    the_plays_playbook.play_id = params.fetch("query_play_id")
    the_plays_playbook.playbook_id = params.fetch("query_playbook_id")

    if the_plays_playbook.valid?
      the_plays_playbook.save
      redirect_to("/plays_playbooks/#{the_plays_playbook.id}", { :notice => "Plays playbook updated successfully." } )
    else
      redirect_to("/plays_playbooks/#{the_plays_playbook.id}", { :alert => the_plays_playbook.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_plays_playbook = PlaysPlaybook.where({ :id => the_id }).at(0)

    the_plays_playbook.destroy

    redirect_to("/plays_playbooks", { :notice => "Plays playbook deleted successfully." } )
  end
end

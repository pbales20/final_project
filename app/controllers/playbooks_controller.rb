class PlaybooksController < ApplicationController
  def index
    matching_playbooks = Playbook.all

    @list_of_playbooks = matching_playbooks.order({ :side_of_ball => :desc, :playbook_name => :asc })

    render({ :template => "playbook_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_playbooks = Playbook.where({ :id => the_id })

    @the_playbook = matching_playbooks.at(0)

    render({ :template => "playbook_templates/show" })
  end

  def create
    the_playbook = Playbook.new
    the_playbook.playbook_name = params.fetch("query_playbook_name")
    the_playbook.side_of_ball = params.fetch("query_side_of_ball")
    the_playbook.user_id = params.fetch("query_user_id")
    the_playbook.scheme_id = params.fetch("query_scheme_id")
    the_playbook.plays_playbooks_count = params.fetch("query_plays_playbooks_count")

    if the_playbook.valid?
      the_playbook.save
      redirect_to("/playbooks", { :notice => "Playbook created successfully." })
    else
      redirect_to("/playbooks", { :alert => the_playbook.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_playbook = Playbook.where({ :id => the_id }).at(0)

    the_playbook.playbook_name = params.fetch("query_playbook_name")
    the_playbook.side_of_ball = params.fetch("query_side_of_ball")
    the_playbook.user_id = params.fetch("query_user_id")
    the_playbook.scheme_id = params.fetch("query_scheme_id")
    the_playbook.plays_playbooks_count = params.fetch("query_plays_playbooks_count")

    if the_playbook.valid?
      the_playbook.save
      redirect_to("/playbooks/#{the_playbook.id}", { :notice => "Playbook updated successfully." } )
    else
      redirect_to("/playbooks/#{the_playbook.id}", { :alert => the_playbook.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_playbook = Playbook.where({ :id => the_id }).at(0)

    the_playbook.destroy

    redirect_to("/playbooks", { :notice => "Playbook deleted successfully." } )
  end
end

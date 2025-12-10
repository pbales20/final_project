class PlayratingsController < ApplicationController
  def index
    matching_playratings = Playrating.all

    @list_of_playratings = matching_playratings.order({ :created_at => :desc })

    render({ :template => "playrating_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_playratings = Playrating.where({ :id => the_id })

    @the_playrating = matching_playratings.at(0)

    render({ :template => "playrating_templates/show" })
  end

  def create
    the_playrating = Playrating.new
    the_playrating.play_id = params.fetch("query_play_id")
    the_playrating.user_id = current_user.id
    the_playrating.favorite = params.fetch("query_favorite")

    if the_playrating.valid?
      the_playrating.save
      redirect_to("/playratings", { :notice => "Playrating created successfully." })
    else
      redirect_to("/playratings", { :alert => the_playrating.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_playrating = Playrating.where({ :id => the_id }).at(0)

    the_playrating.play_id = params.fetch("query_play_id")
    the_playrating.user_id = params.fetch("query_user_id")
    the_playrating.favorite = params.fetch("query_favorite")

    if the_playrating.valid?
      the_playrating.save
      redirect_to("/playratings/#{the_playrating.id}", { :notice => "Playrating updated successfully." } )
    else
      redirect_to("/playratings/#{the_playrating.id}", { :alert => the_playrating.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_playrating = Playrating.where({ :id => the_id }).at(0)

    the_playrating.destroy

    redirect_to("/playratings", { :notice => "Playrating deleted successfully." } )
  end
end

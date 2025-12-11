class FormationSetsController < ApplicationController
  def index
    matching_formation_sets = FormationSet.all

    @list_of_formation_sets = matching_formation_sets.order({ :created_at => :desc })

    render({ :template => "formation_set_templates/index" })
  end



  def show
    the_id = params.fetch("path_id")

    matching_formation_sets = FormationSet.where({ :id => the_id })

    @the_formation_set = matching_formation_sets.at(0)


    matching_plays = Play.where({ :formation_set_id => the_id })

    @list_of_plays = matching_plays.order({ :created_at => :desc })

    render({ :template => "formation_set_templates/show" })
  end

  def create
    the_formation_set = FormationSet.new
    the_formation_set.formation_id = params.fetch("query_formation_id")
    the_formation_set.formation_set = params.fetch("query_formation_set")
    the_formation_set.personnel_group_id = params.fetch("query_personnel_group_id")
    the_formation_set.set_art = params.fetch("query_set_art")
    the_formation_set.description = params.fetch("query_description")
    the_formation_set.plays_count = params.fetch("query_plays_count")

    if the_formation_set.valid?
      the_formation_set.save
      redirect_to("/formation_sets", { :notice => "Formation set created successfully." })
    else
      redirect_to("/formation_sets", { :alert => the_formation_set.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_formation_set = FormationSet.where({ :id => the_id }).at(0)

    the_formation_set.formation_id = params.fetch("query_formation_id")
    the_formation_set.formation_set = params.fetch("query_formation_set")
    the_formation_set.personnel_group_id = params.fetch("query_personnel_group_id")
    the_formation_set.set_art = params.fetch("query_set_art")
    the_formation_set.description = params.fetch("query_description")
    the_formation_set.plays_count = params.fetch("query_plays_count")

    if the_formation_set.valid?
      the_formation_set.save
      redirect_to("/formation_sets/#{the_formation_set.id}", { :notice => "Formation set updated successfully." } )
    else
      redirect_to("/formation_sets/#{the_formation_set.id}", { :alert => the_formation_set.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_formation_set = FormationSet.where({ :id => the_id }).at(0)

    the_formation_set.destroy

    redirect_to("/formation_sets", { :notice => "Formation set deleted successfully." } )
  end
end

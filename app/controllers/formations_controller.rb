class FormationsController < ApplicationController
  def index
    matching_formations = Formation.all

    @list_of_formations = matching_formations.order({ :created_at => :desc })

    render({ :template => "formation_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_formations = Formation.where({ :id => the_id })

    @the_formation = matching_formations.at(0)

    matching_formation_sets = FormationSet.where({ :formation_id => the_id })

    @list_of_formation_sets = matching_formation_sets.order({ :created_at => :desc })

    render({ :template => "formation_templates/show" })
  end

  def create
    the_formation = Formation.new
    the_formation.formation_name = params.fetch("query_formation_name")
    the_formation.formation_art = params.fetch("query_formation_art")
    the_formation.description = params.fetch("query_description")
    the_formation.side_of_ball = params.fetch("query_side_of_ball")
    the_formation.formation_sets_count = params.fetch("query_formation_sets_count")

    if the_formation.valid?
      the_formation.save
      redirect_to("/formations", { :notice => "Formation created successfully." })
    else
      redirect_to("/formations", { :alert => the_formation.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_formation = Formation.where({ :id => the_id }).at(0)

    the_formation.formation_name = params.fetch("query_formation_name")
    the_formation.formation_art = params.fetch("query_formation_art")
    the_formation.description = params.fetch("query_description")
    the_formation.side_of_ball = params.fetch("query_side_of_ball")
    the_formation.formation_sets_count = params.fetch("query_formation_sets_count")

    if the_formation.valid?
      the_formation.save
      redirect_to("/formations/#{the_formation.id}", { :notice => "Formation updated successfully." } )
    else
      redirect_to("/formations/#{the_formation.id}", { :alert => the_formation.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_formation = Formation.where({ :id => the_id }).at(0)

    the_formation.destroy

    redirect_to("/formations", { :notice => "Formation deleted successfully." } )
  end
end

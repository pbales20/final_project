class PlaysConceptsController < ApplicationController
  def index
    matching_plays_concepts = PlaysConcept.all

    @list_of_plays_concepts = matching_plays_concepts.order({ :created_at => :desc })

    render({ :template => "plays_concept_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_plays_concepts = PlaysConcept.where({ :id => the_id })

    @the_plays_concept = matching_plays_concepts.at(0)

    render({ :template => "plays_concept_templates/show" })
  end

  def create
    the_plays_concept = PlaysConcept.new
    the_plays_concept.play_id = params.fetch("query_play_id")
    the_plays_concept.concept_id = params.fetch("query_concept_id")

    if the_plays_concept.valid?
      the_plays_concept.save
      redirect_to("/plays_concepts", { :notice => "Plays concept created successfully." })
    else
      redirect_to("/plays_concepts", { :alert => the_plays_concept.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_plays_concept = PlaysConcept.where({ :id => the_id }).at(0)

    the_plays_concept.play_id = params.fetch("query_play_id")
    the_plays_concept.concept_id = params.fetch("query_concept_id")

    if the_plays_concept.valid?
      the_plays_concept.save
      redirect_to("/plays_concepts/#{the_plays_concept.id}", { :notice => "Plays concept updated successfully." } )
    else
      redirect_to("/plays_concepts/#{the_plays_concept.id}", { :alert => the_plays_concept.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_plays_concept = PlaysConcept.where({ :id => the_id }).at(0)

    the_plays_concept.destroy

    redirect_to("/plays_concepts", { :notice => "Plays concept deleted successfully." } )
  end
end

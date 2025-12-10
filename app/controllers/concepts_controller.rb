class ConceptsController < ApplicationController
  def index
    matching_concepts = Concept.all

    @list_of_concepts = matching_concepts.order({ :created_at => :desc })

    render({ :template => "concept_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_concepts = Concept.where({ :id => the_id })

    @the_concept = matching_concepts.at(0)

    render({ :template => "concept_templates/show" })
  end

  def create
    the_concept = Concept.new
    the_concept.name = params.fetch("query_name")
    the_concept.description = params.fetch("query_description")
    the_concept.side_of_ball = params.fetch("query_side_of_ball")

    if the_concept.valid?
      the_concept.save
      redirect_to("/concepts", { :notice => "Concept created successfully." })
    else
      redirect_to("/concepts", { :alert => the_concept.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_concept = Concept.where({ :id => the_id }).at(0)

    the_concept.name = params.fetch("query_name")
    the_concept.description = params.fetch("query_description")
    the_concept.side_of_ball = params.fetch("query_side_of_ball")

    if the_concept.valid?
      the_concept.save
      redirect_to("/concepts/#{the_concept.id}", { :notice => "Concept updated successfully." } )
    else
      redirect_to("/concepts/#{the_concept.id}", { :alert => the_concept.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_concept = Concept.where({ :id => the_id }).at(0)

    the_concept.destroy

    redirect_to("/concepts", { :notice => "Concept deleted successfully." } )
  end
end

class SchemesConceptsController < ApplicationController
  def index
    matching_schemes_concepts = SchemesConcept.all

    @list_of_schemes_concepts = matching_schemes_concepts.order({ :created_at => :desc })

    render({ :template => "schemes_concept_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_schemes_concepts = SchemesConcept.where({ :id => the_id })

    @the_schemes_concept = matching_schemes_concepts.at(0)

    render({ :template => "schemes_concept_templates/show" })
  end

  def create
    the_schemes_concept = SchemesConcept.new
    the_schemes_concept.scheme_id = params.fetch("query_scheme_id")
    the_schemes_concept.concept_id = params.fetch("query_concept_id")

    if the_schemes_concept.valid?
      the_schemes_concept.save
      redirect_to("/schemes_concepts", { :notice => "Schemes concept created successfully." })
    else
      redirect_to("/schemes_concepts", { :alert => the_schemes_concept.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_schemes_concept = SchemesConcept.where({ :id => the_id }).at(0)

    the_schemes_concept.scheme_id = params.fetch("query_scheme_id")
    the_schemes_concept.concept_id = params.fetch("query_concept_id")

    if the_schemes_concept.valid?
      the_schemes_concept.save
      redirect_to("/schemes_concepts/#{the_schemes_concept.id}", { :notice => "Schemes concept updated successfully." } )
    else
      redirect_to("/schemes_concepts/#{the_schemes_concept.id}", { :alert => the_schemes_concept.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_schemes_concept = SchemesConcept.where({ :id => the_id }).at(0)

    the_schemes_concept.destroy

    redirect_to("/schemes_concepts", { :notice => "Schemes concept deleted successfully." } )
  end
end

class SchemesController < ApplicationController
  def index
    matching_schemes = Scheme.all

    @list_of_schemes = matching_schemes.order({ :created_at => :desc })

    render({ :template => "scheme_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_schemes = Scheme.where({ :id => the_id })

    @the_scheme = matching_schemes.at(0)

    render({ :template => "scheme_templates/show" })
  end

  def create
    the_scheme = Scheme.new
    the_scheme.name = params.fetch("query_name")
    the_scheme.description = params.fetch("query_description")
    the_scheme.side_of_ball = params.fetch("query_side_of_ball")

    if the_scheme.valid?
      the_scheme.save
      redirect_to("/schemes", { :notice => "Scheme created successfully." })
    else
      redirect_to("/schemes", { :alert => the_scheme.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_scheme = Scheme.where({ :id => the_id }).at(0)

    the_scheme.name = params.fetch("query_name")
    the_scheme.description = params.fetch("query_description")
    the_scheme.side_of_ball = params.fetch("query_side_of_ball")

    if the_scheme.valid?
      the_scheme.save
      redirect_to("/schemes/#{the_scheme.id}", { :notice => "Scheme updated successfully." } )
    else
      redirect_to("/schemes/#{the_scheme.id}", { :alert => the_scheme.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_scheme = Scheme.where({ :id => the_id }).at(0)

    the_scheme.destroy

    redirect_to("/schemes", { :notice => "Scheme deleted successfully." } )
  end
end

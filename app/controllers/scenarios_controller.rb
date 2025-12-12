class ScenariosController < ApplicationController
  def index
    matching_scenarios = Scenario.all

    @list_of_scenarios = matching_scenarios.order({ :created_at => :desc })

    render({ :template => "scenario_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_scenarios = Scenario.where({ :id => the_id })

    @the_scenario = matching_scenarios.at(0)

    render({ :template => "scenario_templates/show" })
  end

  def create
    the_scenario = Scenario.new
    the_scenario.name = params.fetch("query_name")
    the_scenario.description = params.fetch("query_description")
    the_scenario.side_of_ball = params.fetch("query_side_of_ball")

    if the_scenario.valid?
      the_scenario.save
      redirect_to("/scenarios", { :notice => "Scenario created successfully." })
    else
      redirect_to("/scenarios", { :alert => the_scenario.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_scenario = Scenario.where({ :id => the_id }).at(0)

    the_scenario.name = params.fetch("query_name")
    the_scenario.description = params.fetch("query_description")
    the_scenario.side_of_ball = params.fetch("query_side_of_ball")

    if the_scenario.valid?
      the_scenario.save
      redirect_to("/scenarios/#{the_scenario.id}", { :notice => "Scenario updated successfully." } )
    else
      redirect_to("/scenarios/#{the_scenario.id}", { :alert => the_scenario.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_scenario = Scenario.where({ :id => the_id }).at(0)

    the_scenario.destroy

    redirect_to("/scenarios", { :notice => "Scenario deleted successfully." } )
  end
end

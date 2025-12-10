class PersonnelGroupsController < ApplicationController
  def index
    matching_personnel_groups = PersonnelGroup.all

    @list_of_personnel_groups = matching_personnel_groups.order({ :created_at => :desc })

    render({ :template => "personnel_group_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_personnel_groups = PersonnelGroup.where({ :id => the_id })

    @the_personnel_group = matching_personnel_groups.at(0)

    render({ :template => "personnel_group_templates/show" })
  end

  def create
    the_personnel_group = PersonnelGroup.new
    the_personnel_group.name = params.fetch("query_name")
    the_personnel_group.number_of_tight_ends = params.fetch("query_number_of_tight_ends")
    the_personnel_group.number_of_running_backs = params.fetch("query_number_of_running_backs")
    the_personnel_group.number_of_wide_receivers = params.fetch("query_number_of_wide_receivers")
    the_personnel_group.number_of_defensive_linemen = params.fetch("query_number_of_defensive_linemen")
    the_personnel_group.number_of_linebackers = params.fetch("query_number_of_linebackers")
    the_personnel_group.number_of_cornerbacks = params.fetch("query_number_of_cornerbacks")
    the_personnel_group.number_of_safeties = params.fetch("query_number_of_safeties")
    the_personnel_group.side_of_ball = params.fetch("query_side_of_ball")

    if the_personnel_group.valid?
      the_personnel_group.save
      redirect_to("/personnel_groups", { :notice => "Personnel group created successfully." })
    else
      redirect_to("/personnel_groups", { :alert => the_personnel_group.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_personnel_group = PersonnelGroup.where({ :id => the_id }).at(0)

    the_personnel_group.name = params.fetch("query_name")
    the_personnel_group.number_of_tight_ends = params.fetch("query_number_of_tight_ends")
    the_personnel_group.number_of_running_backs = params.fetch("query_number_of_running_backs")
    the_personnel_group.number_of_wide_receivers = params.fetch("query_number_of_wide_receivers")
    the_personnel_group.number_of_defensive_linemen = params.fetch("query_number_of_defensive_linemen")
    the_personnel_group.number_of_linebackers = params.fetch("query_number_of_linebackers")
    the_personnel_group.number_of_cornerbacks = params.fetch("query_number_of_cornerbacks")
    the_personnel_group.number_of_safeties = params.fetch("query_number_of_safeties")
    the_personnel_group.side_of_ball = params.fetch("query_side_of_ball")

    if the_personnel_group.valid?
      the_personnel_group.save
      redirect_to("/personnel_groups/#{the_personnel_group.id}", { :notice => "Personnel group updated successfully." } )
    else
      redirect_to("/personnel_groups/#{the_personnel_group.id}", { :alert => the_personnel_group.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_personnel_group = PersonnelGroup.where({ :id => the_id }).at(0)

    the_personnel_group.destroy

    redirect_to("/personnel_groups", { :notice => "Personnel group deleted successfully." } )
  end
end

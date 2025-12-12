class PlaysheetsController < ApplicationController
  def index
  @playbooks = Playbook.order(:playbook_name)



    matching_playsheets = Playsheet.all

    @list_of_playsheets = matching_playsheets.order({ :created_at => :desc })

    render({ :template => "playsheet_templates/index" })
  end

def show
  the_id = params.fetch("path_id")
  @the_playsheet = Playsheet.find(the_id)

  # Plays eligible to add = plays in this playsheet's playbook
  play_ids_in_playbook = PlaysPlaybook
    .where(playbook_id: @the_playsheet.playbook_id)
    .select(:play_id)
@scenarios = Scenario
  .where(side_of_ball: @the_playsheet.side_of_ball)
  .order(:name)
  # Selected plays already on this playsheet
  @selected_play_ids = PlaysPlaysheet
    .where(playsheet_id: @the_playsheet.id)
    .pluck(:play_id)
    .to_set

  @selected_plays = Play.where(id: @selected_play_ids)
                        .includes(:formation, :formation_set)
@playsheet_entries = PlaysPlaysheet
  .includes(:scenario)
  .where(playsheet_id: @the_playsheet.id)
  .index_by(&:play_id)

  # Favorites (for filter UI, and for rendering checked stars elsewhere if you want)
  @favorite_play_ids = Playfavorite
    .where(user_id: current_user.id)
    .pluck(:play_id)
    .to_set

  # Ransack over only plays in this playbook
  base_scope = Play.where(id: play_ids_in_playbook)
  @q = base_scope.ransack(params[:q])

  plays_scope = @q.result(distinct: true)
                  .includes(:formation, :formation_set)

  # Favorites-only filter
  if params[:favorites_only] == "1"
    plays_scope = plays_scope.where(
      id: Playfavorite.where(user_id: current_user.id).select(:play_id)
    )
  end

  # Dropdown options from the filtered scope
  formation_ids     = plays_scope.joins(:formation).distinct.pluck("formations.id")
  formation_set_ids = plays_scope.distinct.pluck(:formation_set_id)

  @formations     = Formation.where(id: formation_ids).order(:formation_name)
  @formation_sets = FormationSet.where(id: formation_set_ids).order(:formation_set)

  # Pagination
  @page     = params.fetch(:page, 1).to_i
  @per_page = 25

  @total_plays  = plays_scope.count
  @total_pages  = (@total_plays.to_f / @per_page).ceil

  @list_of_plays = plays_scope
                     .order(:play)
                     .limit(@per_page)
                     .offset((@page - 1) * @per_page)

  render template: "playsheet_templates/show"
end

  def create
    @playbooks = Playbook.order(:playbook_name => :asc)
    the_playsheet = Playsheet.new
    the_playsheet.user_id = current_user.id
    the_playsheet.playsheet_name = params.fetch("query_playsheet_name")
    the_playsheet.side_of_ball = params.fetch("query_side_of_ball")
    the_playsheet.playbook_id = params.fetch("query_playbook_id")

    if the_playsheet.valid?
      the_playsheet.save
      redirect_to("/playsheets", { :notice => "Playsheet created successfully." })
    else
      redirect_to("/playsheets", { :alert => the_playsheet.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_playsheet = Playsheet.where({ :id => the_id }).at(0)

    the_playsheet.user_id = params.fetch("query_user_id")
    the_playsheet.playsheet_name = params.fetch("query_playsheet_name")
    the_playsheet.side_of_ball = params.fetch("query_side_of_ball")
    the_playsheet.playbook_id = params.fetch("query_playbook_id")

    if the_playsheet.valid?
      the_playsheet.save
      redirect_to("/playsheets/#{the_playsheet.id}", { :notice => "Playsheet updated successfully." } )
    else
      redirect_to("/playsheets/#{the_playsheet.id}", { :alert => the_playsheet.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_playsheet = Playsheet.where({ :id => the_id }).at(0)

    the_playsheet.destroy

    redirect_to("/playsheets", { :notice => "Playsheet deleted successfully." } )
  end
end

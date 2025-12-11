class PlaysController < ApplicationController
def ransackindex
  # 1) Base Ransack search on Play
  @q = Play.ransack(params[:q])

  # 2) Apply all Ransack filters (play name, desc, side_of_ball, formation, formation_set, playbook, etc.)
  plays_scope = @q.result(distinct: true)
                  .includes(:formation_set, :formation, :playbooks)

  # 3) Build dropdown options *from the filtered plays*
  formation_ids     = plays_scope.joins(:formation).distinct.pluck("formations.id")
  formation_set_ids = plays_scope.distinct.pluck(:formation_set_id)
  playbook_ids      = plays_scope.joins(:playbooks).distinct.pluck("playbooks.id")

  @formations     = Formation.where(id: formation_ids).order(:formation_name)
  @formation_sets = FormationSet.where(id: formation_set_ids).order(:formation_set)
  @playbooks      = Playbook.where(id: playbook_ids).order(:playbook_name)

  # 4) Pagination
  @page     = params.fetch(:page, 1).to_i
  @per_page = 25

  @total_plays = plays_scope.count
  @total_pages = (@total_plays.to_f / @per_page).ceil

  @list_of_plays = plays_scope
                     .order(:side_of_ball, :play)
                     .limit(@per_page)
                     .offset((@page - 1) * @per_page)

  render template: "play_templates/ransack_index"
end




def index
  # For dropdowns

  if params[:side_of_ball].present?
    formations = Formation.where(side_of_ball: params[:side_of_ball])
  else
    formations = Formation.all
  end

  if params[:side_of_ball].present?
    playbooks = Playbook.where(side_of_ball: params[:side_of_ball])
  else
    playbooks = Playbook.all
  end

   if params[:formation_set_formation_id_eq].present?
    formation_sets = FormationSet
                        .where(formation_id: params[:formation_set_formation_id_eq])

   else
    formation_sets = FormationSet.all
   end

  @playbooks       = playbooks.order(:playbook_name)
  @formations      = formations.order(:formation_name)
  @formation_sets  = formation_sets.order(:formation_set)

  # Base query
  plays = Play.includes(:formation, :formation_set)

  # Filters
  if params[:side_of_ball].present?
    plays = plays.where(side_of_ball: params[:side_of_ball])
  end

if params[:formation_id].present?
  # Find all formation_sets that belong to this formation
  formation_set_ids = FormationSet
                        .where(formation_id: params[:formation_id])
                        .select(:id)

  # Filter plays to only those whose formation_set is in that list
  plays = plays.where(formation_set_id: formation_set_ids)
end

if params[:playbook_id].present?
  # Find all plays that belong to this playbook
  play_ids = PlaysPlaybook
                        .where(playbook_id: params[:playbook_id])
                        .select(:id)

  # Filter plays to only those whose formation_set is in that list
  plays = plays.where(id: play_ids)
else
  plays = Play.all
end

  if params[:formation_set_id].present?
    plays = plays.where(formation_set_id: params[:formation_set_id])
  end

  if params[:play_search].present?
    plays = plays.where("play ILIKE ?", "%#{params[:play_search]}%")
  end

  # ✅ Pagination
  @page     = params.fetch(:page, 1).to_i
  @per_page = 25  # change this if you want more/less per page
  # make per page limit evenutally a selection by the user

  @total_plays   = plays.count
  @total_pages   = (@total_plays.to_f / @per_page).ceil

  @list_of_plays = plays
                     .order(:side_of_ball, :play)
                     .limit(@per_page)
                     .offset((@page - 1) * @per_page)
  render({ :template => "play_templates/index" })
enddef index
  # For dropdowns

  if params[:side_of_ball].present?
    formations = Formation.where(side_of_ball: params[:side_of_ball])
  else
    formations = Formation.all
  end

  if params[:side_of_ball].present?
    playbooks = Playbook.where(side_of_ball: params[:side_of_ball])
  else
    playbooks = Playbook.all
  end

   if params[:formation_id].present?
    formation_sets = FormationSet
                        .where(formation_id: params[:formation_id])

   else
    formation_sets = FormationSet.all
   end

  @playbooks       = playbooks.order(:playbook_name)
  @formations      = formations.order(:formation_name)
  @formation_sets  = formation_sets.order(:formation_set)

  # Base query
  plays = Play.includes(:formation, :formation_set)

  # Filters
  if params[:side_of_ball].present?
    plays = plays.where(side_of_ball: params[:side_of_ball])
  end

if params[:formation_id].present?
  # Find all formation_sets that belong to this formation
  formation_set_ids = FormationSet
                        .where(formation_id: params[:formation_id])
                        .select(:id)

  # Filter plays to only those whose formation_set is in that list
  plays = plays.where(formation_set_id: formation_set_ids)
end

if params[:playbook_id].present?
  # Find all plays that belong to this playbook
  play_ids = PlaysPlaybook
                        .where(playbook_id: params[:playbook_id])
                        .select(:id)

  # Filter plays to only those whose formation_set is in that list
  plays = plays.where(id: play_ids)
else
  plays = Play.all
end

  if params[:formation_set_id].present?
    plays = plays.where(formation_set_id: params[:formation_set_id])
  end

  if params[:play_search].present?
    plays = plays.where("play ILIKE ?", "%#{params[:play_search]}%")
  end

  # ✅ Pagination
  @page     = params.fetch(:page, 1).to_i
  @per_page = 25  # change this if you want more/less per page
  # make per page limit evenutally a selection by the user

  @total_plays   = plays.count
  @total_pages   = (@total_plays.to_f / @per_page).ceil

  @list_of_plays = plays
                     .order(:side_of_ball, :play)
                     .limit(@per_page)
                     .offset((@page - 1) * @per_page)
  render({ :template => "play_templates/index" })
end

  def show
    the_id = params.fetch("path_id")

    matching_plays = Play.where({ :id => the_id })

    @the_play = matching_plays.at(0)

    render({ :template => "play_templates/show" })
  end

  def create
    the_play = Play.new
    the_play.play = params.fetch("query_play")
    the_play.formation_set_id = params.fetch("query_formation_set_id")
    the_play.play_art = params.fetch("query_play_art")
    the_play.side_of_ball = params.fetch("query_side_of_ball")
    the_play.description = params.fetch("query_description")

    if the_play.valid?
      the_play.save
      redirect_to("/plays", { :notice => "Play created successfully." })
    else
      redirect_to("/plays", { :alert => the_play.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_play = Play.where({ :id => the_id }).at(0)

    the_play.play = params.fetch("query_play")
    the_play.formation_set_id = params.fetch("query_formation_set_id")
    the_play.play_art = params.fetch("query_play_art")
    the_play.side_of_ball = params.fetch("query_side_of_ball")
    the_play.description = params.fetch("query_description")

    if the_play.valid?
      the_play.save
      redirect_to("/plays/#{the_play.id}", { :notice => "Play updated successfully." } )
    else
      redirect_to("/plays/#{the_play.id}", { :alert => the_play.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_play = Play.where({ :id => the_id }).at(0)

    the_play.destroy

    redirect_to("/plays", { :notice => "Play deleted successfully." } )
  end
end

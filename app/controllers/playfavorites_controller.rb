class PlayfavoritesController < ApplicationController
  def index
    matching_playfavorites = Playfavorite.all

    @list_of_playfavorites = matching_playfavorites.order({ :created_at => :desc })

    render({ :template => "playfavorite_templates/index" })
  end

def update_favorites
  submitted_ids = Array(params[:play_ids]).map(&:to_i)

  existing_ids = Playfavorite
    .where(user_id: current_user.id)
    .pluck(:play_id)

  # add
  (submitted_ids - existing_ids).each do |play_id|
    Playfavorite.find_or_create_by!(
      user_id: current_user.id,
      play_id: play_id
    )
  end

  # remove
  Playfavorite.where(
    user_id: current_user.id,
    play_id: (existing_ids - submitted_ids)
  ).delete_all

  redirect_back(
    fallback_location: plays_path,
    notice: "Favorites updated."
  )
end

  def show
    the_id = params.fetch("path_id")

    matching_playfavorites = Playfavorite.where({ :id => the_id })

    @the_playfavorite = matching_playfavorites.at(0)

    render({ :template => "playfavorite_templates/show" })
  end

  def create
    the_playfavorite = Playfavorite.new
the_playfavorite.user_id = current_user.id
the_playfavorite.play_id = params.fetch("query_play_id")


    if the_playfavorite.valid?
      the_playfavorite.save
      redirect_to("/playfavorites", { :notice => "Playfavorite created successfully." })
    else
      redirect_to("/playfavorites", { :alert => the_playfavorite.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_playfavorite = Playfavorite.where({ :id => the_id }).at(0)

    the_playfavorite.user_id = params.fetch("query_user_id")
    the_playfavorite.play_id = params.fetch("query_play_id")

    if the_playfavorite.valid?
      the_playfavorite.save
      redirect_to("/playfavorites/#{the_playfavorite.id}", { :notice => "Playfavorite updated successfully." } )
    else
      redirect_to("/playfavorites/#{the_playfavorite.id}", { :alert => the_playfavorite.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_playfavorite = Playfavorite.where({ :id => the_id }).at(0)

    the_playfavorite.destroy

    redirect_to("/playfavorites", { :notice => "Playfavorite deleted successfully." } )
  end
end

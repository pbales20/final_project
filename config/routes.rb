Rails.application.routes.draw do
  # Routes for the Playrating resource:

  # CREATE
  post("/insert_playrating", { :controller => "playratings", :action => "create" })

  # READ
  get("/playratings", { :controller => "playratings", :action => "index" })

  get("/playratings/:path_id", { :controller => "playratings", :action => "show" })

  # UPDATE

  post("/modify_playrating/:path_id", { :controller => "playratings", :action => "update" })

  # DELETE
  get("/delete_playrating/:path_id", { :controller => "playratings", :action => "destroy" })

  #------------------------------

  # Routes for the Plays concept resource:
  get("/", { :controller => "misc", :action => "homepage" })
  # CREATE
  post("/insert_plays_concept", { :controller => "plays_concepts", :action => "create" })

  # READ
  get("/plays_concepts", { :controller => "plays_concepts", :action => "index" })

  get("/plays_concepts/:path_id", { :controller => "plays_concepts", :action => "show" })

  # UPDATE

  post("/modify_plays_concept/:path_id", { :controller => "plays_concepts", :action => "update" })

  # DELETE
  get("/delete_plays_concept/:path_id", { :controller => "plays_concepts", :action => "destroy" })

  #------------------------------

  # Routes for the Scheme resource:

  # CREATE
  post("/insert_scheme", { :controller => "schemes", :action => "create" })

  # READ
  get("/schemes", { :controller => "schemes", :action => "index" })

  get("/schemes/:path_id", { :controller => "schemes", :action => "show" })

  # UPDATE

  post("/modify_scheme/:path_id", { :controller => "schemes", :action => "update" })

  # DELETE
  get("/delete_scheme/:path_id", { :controller => "schemes", :action => "destroy" })

  #------------------------------

  # Routes for the Schemes concept resource:

  # CREATE
  post("/insert_schemes_concept", { :controller => "schemes_concepts", :action => "create" })

  # READ
  get("/schemes_concepts", { :controller => "schemes_concepts", :action => "index" })

  get("/schemes_concepts/:path_id", { :controller => "schemes_concepts", :action => "show" })

  # UPDATE

  post("/modify_schemes_concept/:path_id", { :controller => "schemes_concepts", :action => "update" })

  # DELETE
  get("/delete_schemes_concept/:path_id", { :controller => "schemes_concepts", :action => "destroy" })

  #------------------------------

  # Routes for the Concept resource:

  # CREATE
  post("/insert_concept", { :controller => "concepts", :action => "create" })

  # READ
  get("/concepts", { :controller => "concepts", :action => "index" })

  get("/concepts/:path_id", { :controller => "concepts", :action => "show" })

  # UPDATE

  post("/modify_concept/:path_id", { :controller => "concepts", :action => "update" })

  # DELETE
  get("/delete_concept/:path_id", { :controller => "concepts", :action => "destroy" })

  #------------------------------

  # Routes for the Package resource:

  # CREATE
  post("/insert_package", { :controller => "packages", :action => "create" })

  # READ
  get("/packages", { :controller => "packages", :action => "index" })

  get("/packages/:path_id", { :controller => "packages", :action => "show" })

  # UPDATE

  post("/modify_package/:path_id", { :controller => "packages", :action => "update" })

  # DELETE
  get("/delete_package/:path_id", { :controller => "packages", :action => "destroy" })

  #------------------------------

  # Routes for the Personnel group resource:

  # CREATE
  post("/insert_personnel_group", { :controller => "personnel_groups", :action => "create" })

  # READ
  get("/personnel_groups", { :controller => "personnel_groups", :action => "index" })

  get("/personnel_groups/:path_id", { :controller => "personnel_groups", :action => "show" })

  # UPDATE

  post("/modify_personnel_group/:path_id", { :controller => "personnel_groups", :action => "update" })

  # DELETE
  get("/delete_personnel_group/:path_id", { :controller => "personnel_groups", :action => "destroy" })

  #------------------------------

  # Routes for the Plays playsheet resource:

  # CREATE
  post("/insert_plays_playsheet", { :controller => "plays_playsheets", :action => "create" })
# BULK ADD PLAYS TO A PLAYSHEET
  post("/playsheets/:playsheet_id/add_plays", { :controller => "plays_playsheets", :action => "bulk_create" })
  # READ
  get("/plays_playsheets", { :controller => "plays_playsheets", :action => "index" })

  get("/plays_playsheets/:path_id", { :controller => "plays_playsheets", :action => "show" })

  # UPDATE

  post("/modify_plays_playsheet/:path_id", { :controller => "plays_playsheets", :action => "update" })

  # DELETE
  get("/delete_plays_playsheet/:path_id", { :controller => "plays_playsheets", :action => "destroy" })

  #------------------------------

  # Routes for the Plays playbook resource:

  # CREATE
  post("/insert_plays_playbook", { :controller => "plays_playbooks", :action => "create" })

  # READ
  get("/plays_playbooks", { :controller => "plays_playbooks", :action => "index" })

  get("/plays_playbooks/:path_id", { :controller => "plays_playbooks", :action => "show" })

  # UPDATE

  post("/modify_plays_playbook/:path_id", { :controller => "plays_playbooks", :action => "update" })

  # DELETE
  get("/delete_plays_playbook/:path_id", { :controller => "plays_playbooks", :action => "destroy" })

  #------------------------------

  # Routes for the Playsheet resource:

  # CREATE
  post("/insert_playsheet", { :controller => "playsheets", :action => "create" })

  # READ
  get("/playsheets", { :controller => "playsheets", :action => "index" })

  get("/playsheets/:path_id", { :controller => "playsheets", :action => "show" })

  # UPDATE

  post("/modify_playsheet/:path_id", { :controller => "playsheets", :action => "update" })

  # DELETE
  get("/delete_playsheet/:path_id", { :controller => "playsheets", :action => "destroy" })

  #------------------------------

  devise_for :users
  # Routes for the Formation set resource:

  # CREATE
  post("/insert_formation_set", { :controller => "formation_sets", :action => "create" })

  # READ
  get("/formation_sets", { :controller => "formation_sets", :action => "index" })

  get("/formation_sets/:path_id", { :controller => "formation_sets", :action => "show" })

  # UPDATE

  post("/modify_formation_set/:path_id", { :controller => "formation_sets", :action => "update" })

  # DELETE
  get("/delete_formation_set/:path_id", { :controller => "formation_sets", :action => "destroy" })

  #------------------------------

  # Routes for the Formation resource:

  # CREATE
  post("/insert_formation", { :controller => "formations", :action => "create" })

  # READ
  get("/formations", { :controller => "formations", :action => "index" })

  get("/formations/:path_id", { :controller => "formations", :action => "show" })

  # UPDATE

  post("/modify_formation/:path_id", { :controller => "formations", :action => "update" })

  # DELETE
  get("/delete_formation/:path_id", { :controller => "formations", :action => "destroy" })

  #------------------------------

  # Routes for the Playbook resource:

  # CREATE
  post("/insert_playbook", { :controller => "playbooks", :action => "create" })

  # READ
  get("/playbooks", { :controller => "playbooks", :action => "index" })

  get("/playbooks/:path_id", { :controller => "playbooks", :action => "show" })

  # UPDATE

  post("/modify_playbook/:path_id", { :controller => "playbooks", :action => "update" })

  # DELETE
  get("/delete_playbook/:path_id", { :controller => "playbooks", :action => "destroy" })

  #------------------------------

  # Routes for the Play resource:

  # CREATE
  post("/insert_play", { :controller => "plays", :action => "create" })

  # READ
  get("/plays", { :controller => "plays", :action => "ransackindex" })

  get("/plays/:path_id", { :controller => "plays", :action => "show" })

  # UPDATE

  post("/modify_play/:path_id", { :controller => "plays", :action => "update" })

  # DELETE
  get("/delete_play/:path_id", { :controller => "plays", :action => "destroy" })

    # Routes for the Favorite play resource:

  #------------------------------

  # This is a blank app! Pick your first screen, build out the RCAV, and go from there. E.g.:
  # get("/your_first_screen", { :controller => "pages", :action => "first" })
end

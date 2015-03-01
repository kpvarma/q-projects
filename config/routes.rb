QProject::Application.routes.draw do

  ## -----------
  ## Q-Auth URLS
  ## -----------
  mount QAuthRubyClient::Engine, at: "/q-auth", :as => 'q_auth_ruby_client'

  # ------------
  # Public pages
  # ------------

  root :to => 'welcome#home'

  # ------------
  # Admin pages
  # ------------

  namespace :admin do

    resources :projects do
      get :change_status, on: :member
      resources :roles, :only=>[:index, :new, :create, :destroy] do
        collection do
          get 'refresh'
        end
      end
      resources :project_links
    end

    resources :clients
    resources :link_types
    resources :images do
      member do
        put :crop
      end
    end

  end

  # ------------
  # User pages
  # ------------

  namespace :user do
    get   '/dashboard',         to: "dashboard#index",   as:  :dashboard # Landing page after sign in
  end

  # User Pages for teams and user profiles
  get   '/team',               to: "user/team#index",   as:  :team
  get   '/profiles/:username',  to: "user/team#show",    as:  :profile

  # User Pages for projects
  get   '/projects/:pretty_url/dashboard',   to: "user/projects#show",   as:  :project_dashboard

  ## ----------
  ## APIs
  ## ----------

  # Clients API
  get    '/api/v1/clients'            =>  "api/v1/clients#index",  :as => :api_clients
  get    '/api/v1/clients/:id'        =>  "api/v1/clients#show",   :as => :api_client

end

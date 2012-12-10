require 'sidekiq/web'
YoutubeCrawl::Application.routes.draw do
  

  resources :videos
  namespace :api do
    get 'promotion' => 'api#promotion'
    namespace :v1 do
      resources :dramas do
        collection do
          get 'dramas_info'
          get 'dramas_with_views'
        end
      end
      resources :youtube_sources
      resources :eps
    end
  end
  mount Sidekiq::Web, at: '/sidekiq'
end

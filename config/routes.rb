require 'sidekiq/web'
YoutubeCrawl::Application.routes.draw do
  

  resources :videos
  namespace :api do
    namespace :v1 do
      resources :dramas do
        collection do
          get 'dramas_info'
        end
      end
      resources :youtube_sources
      resources :eps
    end
  end
  mount Sidekiq::Web, at: '/sidekiq'
end

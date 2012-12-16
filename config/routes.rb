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
      resources :youtube_sources do
        collection do
          get 'find_by_drama_and_ep_num'
        end
      end
      resources :eps do
        collection do
          get 'update_ep'
        end
      end
    end
  end
  mount Sidekiq::Web, at: '/sidekiq'
end

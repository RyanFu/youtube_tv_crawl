require 'sidekiq/web'
YoutubeCrawl::Application.routes.draw do
  

  resources :eps,:only => [:show, :index, :edit] do 
    collection do
      put 'search'
      put 'update_ep'
    end
  end

  resources :youtube_sources,:only => [:new, :edit,:update,:create,:destroy]

  resources :videos
  namespace :api do
    get 'promotion' => 'api#promotion'
    namespace :v1 do
      resources :dramas do
        collection do
          get 'dramas_info'
          get 'new_dramas_info'
          get 'dramas_with_views'
          get 'dramas_with_views_v2'
          put 'update_device_watch'
        end
      end
      resources :youtube_sources do
        collection do
          get 'find_by_drama_and_ep_num'
        end
      end
      resources :eps

      resources :devices,:only => [:create]
    end
  end
  mount Sidekiq::Web, at: '/sidekiq'
end

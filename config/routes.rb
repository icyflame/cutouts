Rails.application.routes.draw do

  devise_for :admins
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'api_helpers/password_compare'

  scope '/api' do
    scope '/v1' do
      scope '/articles' do
        post '/' => 'api_helpers#article_create'
        get '/' => 'api_helpers#articles_list'
      end
      scope '/users' do
        post '/' => 'api_helpers#user_create'
        scope '/auth' do
          post '/' => 'api_helpers#user_signin'
        end
      end
    end
  end

  scope '/about/' do
    get '/' => 'static#about'
  end

  get 'list_articles/index'

  get '/feed' => 'list_articles#feed'

  get 'user/export_articles'

  devise_for :users
  resources :article

  get 'users' => 'user#index'
  get ':username' => 'user#public_page'

  get 'article/:id/share' => 'article#share'
  post 'article/:id/share' => 'article#send_share'

  root 'static#index'
end

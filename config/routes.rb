Rails.application.routes.draw do
  
  root to: 'public/homes#top'
  devise_scope :customer do
  get '/customers/sign_up', to: 'customers/registrations#new'
  post '/customers', to: 'customers/registrations#create'

  get '/customers/sign_in', to: 'customers/sessions#new'
  post '/customers/sign_in', to: 'customers/sessions#create'
  delete '/customers/sign_out', to: 'customers/sessions#destroy'
end
  
  devise_for :customers, skip: [:registrations, :sessions, :passwords]


  devise_for :admins, controllers: {
  sessions:      'admins/sessions'
}

  scope module: :public do
    # scope module: :●● doで「●●/index」を「/index」みたいな感じに変更できる
    
    get 'about' => 'homes#about'
    resources :items, only: [:index, :show]
    resources :addresses, only: [:index, :edit, :create, :update, :destroy] 
    
    
    # 7つ以外のアクションがある時は，collection(idなし)とmember(id含む)を使って指定する。
    resources :orders, only: [:new, :create, :index, :show] do
      collection do
        post 'confirm'
        get 'complete'
      end
    end
    
    resources :cart_items, only: [:index, :update, :destroy, :create] do
      collection do
        delete 'destroy_all'
      end
    end
    
    
   
    resource :customers, only: [:show, :edit, :update] do
      collection do
        get 'unsubscribe'
        patch 'withdraw'
      end
    end
    
    
  end

  namespace :admin do
    # resourceだけだとidが含まれないかつindexアクションも表示されないから気をつける
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
  end



end

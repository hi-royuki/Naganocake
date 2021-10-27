Rails.application.routes.draw do

  namespace :admin do
    # resourceだけだとidが含まれないかつindexアクションも表示されないから気をつける
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
  end

  devise_for :customers, controllers: {
  sessions:      'customers/sessions',
  passwords:     'customers/passwords',
  registrations: 'customers/registrations'
}
  devise_for :admins, controllers: {
  sessions:      'admins/sessions'
}

end

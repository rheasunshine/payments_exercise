Rails.application.routes.draw do
  defaults format: :json do
    resources :loans do
      resources :payments, only: [:create, :index, :show]
    end
  end
end

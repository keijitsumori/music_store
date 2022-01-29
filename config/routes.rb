Rails.application.routes.draw do
  devise_for :customers, controllers: {
    registrations: "customer/registrations",
    sessions: 'customer/sessions'
  }
  devise_for :admin, controllers: {
    sessions: "admin/sessions"
  }
end

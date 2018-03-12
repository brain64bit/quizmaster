Rails.application.routes.draw do

  post 'quiz/:id/answer', to: 'quiz#answer'
  get  'quiz/next_question', to: 'quiz#next_question'
  get  'quiz/finish', to: 'quiz#finish'

  root to: "quiz#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :admin do
    resources :questions
  end
end

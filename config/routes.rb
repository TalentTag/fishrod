Rails.application.routes.draw do

  root to: "index#entries"

  scope :entries do
    get ':id' => 'index#details', as: :details, constraints: { id: /\d+/ }
    get ':source' => 'index#entries', as: :entries
  end

end

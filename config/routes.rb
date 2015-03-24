Rails.application.routes.draw do

  root to: "index#entries"

  scope :entries do
    get ':source' => 'index#entries', as: :entries
  end

end

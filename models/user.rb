class User
  include Dynamoid::Document  
  include Updater
  has_many :flowers

  field :name
  field :first_name
  field :last_name
  field :email
  field :telephone
  field :address
end


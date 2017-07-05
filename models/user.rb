class User
  include Dynamoid::Document  
  has_many :flowers

  field :name
end


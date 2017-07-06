class Flower < BaseModel
  include Dynamoid::Document 

  field :label, :string
  field :description, :string

  belongs_to :user 
  has_many :petals
  has_many :accounts

end

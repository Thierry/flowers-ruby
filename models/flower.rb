class Flower
  include Dynamoid::Document 
  table :name => :flowers, :key => :id, :read_capacity => 5, :write_capacity => 5

  field :label, :string
  field :description, :string

  belongs_to :user 
  has_many :petals
  has_many :accounts
end


class Flower
  include Dynamoid::Document 
  table :name => :flowers, :key => :id, :read_capacity => 5, :write_capacity => 5

  belongs_to :user 

  has_many :petals
end


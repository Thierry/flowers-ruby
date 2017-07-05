class Petal
  include Dynamoid::Document
  table :name => :petals, :key => :id, :read_capacity => 5, :write_capacity => 5

  belongs_to :flower

  #field :name
  #field :class
  #field :rank, :integer
  #field :number, :number
  #field :joined_at, :datetime
  #field :hash, :serialized
  #field :enabled, :integer

end

class AccountPetal < Petal
  include Dynamoid::Document
  field :IBAN
end


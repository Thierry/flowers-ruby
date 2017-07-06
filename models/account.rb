class Account
  include Dynamoid::Document 
  include Updater
  table :name => :account, :key => :id, :read_capacity => 5, :write_capacity => 5

  belongs_to :flower 

  field :IBAN, :string
  field :label, :string
  field :description, :string
end


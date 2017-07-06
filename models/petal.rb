class Petal < BaseModel
  include Dynamoid::Document
  table :name => :petals, :key => :id, :read_capacity => 5, :write_capacity => 5

  belongs_to :flower

  field :title
  field :petaltype # Action, notification
  field :color, :string
  field :description, :string
  field :seuil, :number
  field :split_key
  field :execution_date
  field :transaction_label

  has_one :watch_account, :class => Account
  has_many :debit_account, :class => Account
  has_many :credit_account, :class => Account

end


class Order < ApplicationRecord
  has_many :order_details
  belongs_to :customer

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { waiting: 0, comfirm: 1, in_production: 2, ready_to_ship: 3, shipped: 4 }
end

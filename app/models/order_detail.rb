class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item

  enum making_status: { couldnt_make: 0, waiting_for_production: 1, in_production: 2, completed: 3 }
end

class EstimateItemDescendant < ApplicationRecord
  belongs_to :parent, :class_name => 'EstimateItem'
  belongs_to :child, :class_name => 'EstimateItem'
end

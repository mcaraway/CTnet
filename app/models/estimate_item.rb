class EstimateItem < ApplicationRecord
  has_many :estimate_item_descendants, :foreign_key => :parent_id
  has_many :children, :through => :estimate_item_descendants, :source => :child
  belongs_to :option_group
  belongs_to :part
  
  def self.search(term)
    order(:name).where("name like ?", "%#{term}%")
  end
  
  def option_group_name
    option_group.try(:name)
  end
  
  def option_group_name=(name)
    self.option_group = OptionGroup.find_by_name(name) if name.present?
  end
  
  def part_name
    part.try(:num)
  end
  
  def part_name=(num)
    self.part = Part.find_by_num(num) if num.present?
  end
end

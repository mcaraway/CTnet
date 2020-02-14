class OptionGroup < ApplicationRecord
  
  def self.search(term)
    order(:name).where("name like ?", "%#{term}%")
  end
end

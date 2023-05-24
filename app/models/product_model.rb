class ProductModel < ApplicationRecord
  belongs_to :supplier

  def full_dimensions
    "#{height}cm X #{width}cm X #{depth}cm"
  end
end

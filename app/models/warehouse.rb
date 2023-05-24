class Warehouse < ApplicationRecord

  validates  :name, :code, :city, :area, :description, :cep, :address, presence: true
  validates :code, uniqueness: true

  def full_description
    "#{code} | #{name}"
  end
end

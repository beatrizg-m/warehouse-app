class Warehouse < ApplicationRecord

  validates :name, :code, :city, :area, :description, :cep, :address, presence: true
end

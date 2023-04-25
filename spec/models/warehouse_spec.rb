require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe '#valid?' do
    it 'false when name is empty' do
       #Arrange
        warehouse = Warehouse.new(name: '', code: 'RIO', city: 'Rio de Janeiro',
                                  area: 10000, cep: '20000-000', address: 'Rua da praia,20', description:'Alguma descricao')
       #Act
        result = warehouse.valid?
       #Assert
       expect(result).to eq false
    end

    it 'false when code is empty' do
      #Arrange
       warehouse = Warehouse.new(name: 'Rio', code: '', city: 'Rio de Janeiro',
                                 area: 10000, cep: '20000-000', address: 'Rua da praia,20', description:'Alguma descricao')
      #Act
       result = warehouse.valid?
      #Assert
      expect(result).to eq false
   end

    it 'false when city is empty' do
      #Arrange
       warehouse = Warehouse.new(name: 'Rio', code: 'RIO', city: '',
                                 area: 10000, cep: '20000-000', address: 'Rua da praia,20', description:'Alguma descricao')
      #Act
       result = warehouse.valid?
      #Assert
      expect(result).to eq false
    end

    it 'false when area is empty' do
      #Arrange
       warehouse = Warehouse.new(name: 'Rio', code: 'RIO', city: 'Rio de Janeiro',
                                 area:'', cep: '20000-000', address: 'Rua da praia,20', description:'Alguma descricao')
      #Act
       result = warehouse.valid?
      #Assert
      expect(result).to eq false
    end

    it 'false when cep is empty' do
      #Arrange
       warehouse = Warehouse.new(name: 'Rio', code: 'RIO', city: 'Rio de Janeiro',
                                 area: 10000, cep: '', address: 'Rua da praia,20', description:'Alguma descricao')
      #Act
       result = warehouse.valid?
      #Assert
      expect(result).to eq false
    end

    it 'false when address is empty' do
      #Arrange
       warehouse = Warehouse.new(name: 'Rio', code: 'RIO', city: 'Rio de Janeiro',
                                 area: 10000, cep: '20000-000', address: '', description:'Alguma descricao')
      #Act
       result = warehouse.valid?
      #Assert
      expect(result).to eq false
    end

    it 'false when description is empty' do
      #Arrange
       warehouse = Warehouse.new(name: 'Rio', code: 'RIO', city: 'Rio de Janeiro',
                                 area: 10000, cep: '20000-000', address: 'Rua da praia,20', description:'')
      #Act
       result = warehouse.valid?
      #Assert
      expect(result).to eq false
    end

    it 'false when code is already in use' do
      #Arrange
      first_warehouse = Warehouse.create(name: 'Rio', code: 'RIO', city: 'Rio de      Janeiro',
                                    area: 10000, cep: '20000-000', address: 'Rua da praia,20', description:'Alguma descricao')

      second_warehouse = Warehouse.create(name: 'Recife', code: 'RIO', city: 'Recife',
                                      area: 12000, cep: '30000-000', address: 'Rua das calcadas ,200', description:'Alguma outra descricao aqui')
      #Act
      result = second_warehouse.valid?
      #Assert
      expect(result).to eq false
    end
  end
end

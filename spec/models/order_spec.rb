require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid' do
    it 'deve ter um codigo' do
      user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
      warehouse = Warehouse.create!(name: 'Galpão do rio', code: 'RIO', city: 'Rio de Janeiro',
                            area: 10000, cep: '20000-000', address: 'Rua da praia,20', description:'Alguma descricao')
      supplier = Supplier.create!(corporate_name:'ACME LTDA', brand_name: 'ACME', registration_number: '2345678912',
                          full_address: 'Av das Ubaias, 50', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
      order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2023-10-20')

      result = order.valid?

      expect(result).to be true
    end

    it 'data estimada de entrega deve ser obrigatória' do
      order = Order.new(estimated_delivery_date: '')

      order.valid?
      result = order.errors.include? :estimated_delivery_date

      expect(result).to be true
    end

    it 'data estimada de entrega não deve ser passada' do
      order = Order.new(estimated_delivery_date: 1.day.ago)

      order.valid?

      expect(order.errors.include? :estimated_delivery_date).to be true
      expect(order.errors[:estimated_delivery_date]).to include(' deve ser futura.')
    end

    it 'data estimada de entrega não deve ser hoje' do
      order = Order.new(estimated_delivery_date: Date.today)

      order.valid?

      expect(order.errors.include? :estimated_delivery_date).to be true
      expect(order.errors[:estimated_delivery_date]).to include(' deve ser futura.')
    end

    it 'data estimada de entrega deve ser igual ou maior que amanhã' do
      order = Order.new(estimated_delivery_date: 1.day.from_now)

      order.valid?

      expect(order.errors.include? :estimated_delivery_date).to be false
    end

  end

  describe 'gera um código aleatório' do
    it 'ao criar um novo pedido' do
      user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
      warehouse = Warehouse.create!(name: 'Galpão do rio', code: 'RIO', city: 'Rio de Janeiro',
                            area: 10000, cep: '20000-000', address: 'Rua da praia,20', description:'Alguma descricao')
      supplier = Supplier.create!(corporate_name:'ACME LTDA', brand_name: 'ACME', registration_number: '2345678912',
                          full_address: 'Av das Ubaias, 50', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
      order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2023-10-20')

      order.save!
      result = order.code

      expect(result).not_to be_empty
      expect(result.length).to eq 8

    end

    it 'e o codigo é unico' do
      user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
      warehouse = Warehouse.create!(name: 'Galpão do rio', code: 'RIO', city: 'Rio de Janeiro',
                            area: 10000, cep: '20000-000', address: 'Rua da praia,20', description:'Alguma descricao')
      supplier = Supplier.create!(corporate_name:'ACME LTDA', brand_name: 'ACME', registration_number: '2345678912',
                          full_address: 'Av das Ubaias, 50', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
      first_order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2023-10-20')
      second_order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

      second_order.save!

      expect(second_order.code).not_to eq first_order.code

    end
  end
end

require 'rails_helper'

describe 'usuário informa novo status do pedido' do
  it 'e pedido foi entregue' do
    gabriel = User.create!(name:'Gabriel', email: 'gabriel@email.com', password: 'password')
    warehouse = Warehouse.create(name: 'Rio', code:'SDU', city: 'Rio de Janeiro', area: 60_000,
                                address: 'Av do porto, 1000', cep: '20000-000', description: 'Galpao do Rio')
    supplier = Supplier.create!(corporate_name:'ACME LTDA', brand_name: 'ACME', registration_number: '2345678912',
                                full_address: 'Av das Ubaias, 50', city: 'Bauru', state: 'SP',
                                email: 'contato@acme.com')
    order = Order.create(user: gabriel, warehouse: warehouse, supplier: supplier,
                          estimated_delivery_date: 1.day.from_now, status: 'pending' )

    login_as gabriel
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Marcar como Entregue'

    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Situação do Pedido: Entregue'
    expect(page).not_to have_content 'Marcar como Entregue'
    expect(page).not_to have_content 'Marcar como Cancelado'

  end

  it 'e pedido foi entregue' do
    gabriel = User.create!(name:'Gabriel', email: 'gabriel@email.com', password: 'password')
    warehouse = Warehouse.create(name: 'Rio', code:'SDU', city: 'Rio de Janeiro', area: 60_000,
                                address: 'Av do porto, 1000', cep: '20000-000', description: 'Galpao do Rio')
    supplier = Supplier.create!(corporate_name:'ACME LTDA', brand_name: 'ACME', registration_number: '2345678912',
                                full_address: 'Av das Ubaias, 50', city: 'Bauru', state: 'SP',
                                email: 'contato@acme.com')
    order = Order.create(user: gabriel, warehouse: warehouse, supplier: supplier,
                          estimated_delivery_date: 1.day.from_now, status: 'pending' )

    login_as gabriel
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Marcar como Cancelado'

    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Situação do Pedido: Cancelado'
    expect(page).not_to have_content 'Marcar como Entregue'
    expect(page).not_to have_content 'Marcar como Cancelado'
  end

end

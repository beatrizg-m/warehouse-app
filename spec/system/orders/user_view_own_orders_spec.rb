require 'rails_helper'

describe 'Usuário vê seus próprios pedidos' do
  it 'e deve estar autenticado' do

    visit root_path
    click_on 'Meus Pedidos'

    expect(current_path).to eq new_user_session_path
  end

  it 'e não vê outros pedidos' do
    beatriz = User.create!(name:'Beatriz', email: 'beatriz@email.com', password: 'password')
    gabriel = User.create!(name:'Gabriel', email: 'gabriel@email.com', password: 'password')
    warehouse = Warehouse.create(name: 'Rio', code:'SDU', city: 'Rio de Janeiro', area: 60_000,
                                address: 'Av do porto, 1000', cep: '20000-000', description: 'Galpao do Rio')
    supplier = Supplier.create!(corporate_name:'ACME LTDA', brand_name: 'ACME', registration_number: '2345678912',
                                full_address: 'Av das Ubaias, 50', city: 'Bauru', state: 'SP',
                                email: 'contato@acme.com')
    order1 = Order.create(user: beatriz, warehouse: warehouse, supplier: supplier,
                          estimated_delivery_date: 1.day.from_now, status: 'pending' )
    order2 = Order.create(user: gabriel, warehouse: warehouse, supplier: supplier,
                          estimated_delivery_date: 1.day.from_now, status: 'delivered' )
    order3 = Order.create(user: beatriz, warehouse: warehouse, supplier: supplier,
                          estimated_delivery_date: 1.week.from_now, status: 'canceled')

    login_as(beatriz)
    visit(root_path)
    click_on 'Meus Pedidos'

    expect(page).to have_content order1.code
    expect(page).to have_content 'Pendente'
    expect(page).not_to have_content order2.code
    expect(page).not_to have_content 'Entregue'
    expect(page).to have_content order3.code
    expect(page).to have_content 'Cancelado'
  end

  it 'e visita um pedido' do
    beatriz = User.create!(name:'Beatriz', email: 'beatriz@email.com', password: 'password')
    warehouse = Warehouse.create(name: 'Rio', code:'SDU', city: 'Rio de Janeiro', area: 60_000,
                                address: 'Av do porto, 1000', cep: '20000-000', description: 'Galpao do Rio')
    supplier = Supplier.create!(corporate_name:'ACME LTDA', brand_name: 'ACME', registration_number: '2345678912',
                                full_address: 'Av das Ubaias, 50', city: 'Bauru', state: 'SP',
                                email: 'contato@acme.com')
    order1 = Order.create(user: beatriz, warehouse: warehouse, supplier: supplier,
                          estimated_delivery_date: 1.day.from_now )
    login_as(beatriz)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order1.code

    expect(page).to have_content 'Detalhes do pedido'
    expect(page).to have_content order1.code
    expect(page).to have_content 'Galpão Destino: SDU | Rio'
    expect(page).to have_content 'Fornecedor: ACME LTDA'
    formated_date = I18n.localize(1.day.from_now.to_date)
    expect(page).to have_content "Data estimada de entrega: #{formated_date}"
  end

  it 'e não visita pedidos de outros usuários' do
    beatriz = User.create!(name:'Beatriz', email: 'beatriz@email.com', password: 'password')
    gabriel = User.create!(name:'Gabriel', email: 'gabriel@email.com', password: 'password')
    warehouse = Warehouse.create(name: 'Aeroporto São Paulo', code:'GRU', city: 'Guarulhos', area: 60_000,
                                address: 'Av do porto, 1000', cep: '20000-000', description: 'Galpao de SP')
    supplier = Supplier.create!(corporate_name:'ACME LTDA', brand_name: 'ACME', registration_number: '2345678912',
                                full_address: 'Av das Ubaias, 50', city: 'Bauru', state: 'SP',
                                email: 'contato@acme.com')
    order1 = Order.create(user: beatriz, warehouse: warehouse, supplier: supplier,
                          estimated_delivery_date: 1.day.from_now )
    login_as(gabriel)
    visit order_path(order1.id)

    expect(current_path).not_to eq order_path(order1.id)
    expect(page).not_to have_content order1.code
    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não possui acesso a este pedido'
  end

end

require 'rails_helper'

describe 'Usuário busca por um pedido' do
  it 'e deve estar autenticado' do
    user = User.create!(name:'Beatriz', email: 'beatriz@email.com', password: 'password')

    login_as(user)
    visit root_path

    within('header nav') do
      expect(page).to have_field('Buscar Pedido')
      expect(page).to have_button('Buscar')
    end
  end

  it 'a partir do menu' do

    visit root_path

    within('header nav') do
      expect(page).not_to have_field('Buscar Pedido')
      expect(page).not_to have_button('Buscar')
    end

  end

  it 'e encontra um pedido' do
    user = User.create!(name:'Beatriz', email: 'beatriz@email.com', password: 'password')
    warehouse = Warehouse.create(name: 'Rio', code:'SDU', city: 'Rio de Janeiro', area: 60_000,
      address: 'Av do porto, 1000', cep: '20000-000', description: 'Galpao do Rio')
    supplier = Supplier.create!(corporate_name:'ACME LTDA', brand_name: 'ACME', registration_number: '2345678912',
      full_address: 'Av das Ubaias, 50', city: 'Bauru', state: 'SP',
      email: 'contato@acme.com')
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)



    login_as(user)
    visit root_path
    fill_in 'Buscar Pedido', with: order.code
    click_on 'Buscar'

    expect(page).to have_content "Resultados da busca por: #{order.code}"
    expect(page).to have_content '1 pedido encontrado'
    expect(page).to have_content "Código #{order.code}"
    expect(page).to have_content "Galpão Destino SDU"
    expect(page).to have_content "Fornecedor ACME LTDA"

  end

  it 'e encontra multiplos pedidos' do
    user = User.create!(name:'Beatriz', email: 'beatriz@email.com', password: 'password')
    first_warehouse = Warehouse.create(name: 'Rio', code:'SDU', city: 'Rio de Janeiro', area: 60_000,
                                      address: 'Av do porto, 1000', cep: '20000-000', description: 'Galpao do Rio')
    second_warehouse = Warehouse.create(name: 'Aeroporto SP', code:'GRU', city: 'Guarulhos', area: 100_000,
                                        address: 'Av Paulista, 100', cep: '15000-000', description: 'Galpao do Rio')
    supplier = Supplier.create!(corporate_name:'ACME LTDA', brand_name: 'ACME', registration_number: '2345678912',
                                full_address: 'Av das Ubaias, 50', city: 'Bauru', state: 'SP',
                                email: 'contato@acme.com')

    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('GRU12345')
    first_order = Order.create!(user: user, warehouse: second_warehouse, supplier: supplier,
                                estimated_delivery_date: 1.day.from_now)

    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('GRU98765')
    second_order = Order.create!(user: user, warehouse: second_warehouse, supplier: supplier,
                                estimated_delivery_date: 1.day.from_now)

    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('SDU12345')
    third_order = Order.create!(user: user, warehouse: first_warehouse, supplier: supplier,
                                estimated_delivery_date: 1.day.from_now)


    #Act
    login_as(user)
    visit root_path
    fill_in 'Buscar Pedido', with: 'GRU'
    click_on 'Buscar'

    expect(page).to have_content '2 pedidos encontrados'
    expect(page).to have_content('GRU12345')
    expect(page).to have_content('GRU98765')
    expect(page).to have_content('Galpão Destino GRU | Aeroporto SP')
    expect(page).not_to have_content('SDU12345')
    expect(page).not_to have_content('Galpão Destino SDU | Rio')


  end
end

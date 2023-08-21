require 'rails_helper'

describe 'Usuário edita o pedido' do
  it 'e deve estar autenticado' do
    beatriz = User.create!(name:'Beatriz', email: 'beatriz@email.com', password: 'password')
    warehouse = Warehouse.create(name: 'Rio', code:'SDU', city: 'Rio de Janeiro', area: 60_000,
                                address: 'Av do porto, 1000', cep: '20000-000', description: 'Galpao do Rio')
    supplier = Supplier.create!(corporate_name:'ACME LTDA', brand_name: 'ACME', registration_number: '2345678912',
                                full_address: 'Av das Ubaias, 50', city: 'Bauru', state: 'SP',
                                email: 'contato@acme.com')
    order1 = Order.create(user: beatriz, warehouse: warehouse, supplier: supplier,
                          estimated_delivery_date: 1.day.from_now )

    visit edit_order_path(order1.id)

    expect(current_path).to eq new_user_session_path
  end

  it 'com sucesso' do
    beatriz = User.create!(name:'Beatriz', email: 'beatriz@email.com', password: 'password')
    warehouse = Warehouse.create(name: 'Rio', code:'SDU', city: 'Rio de Janeiro', area: 60_000,
                                address: 'Av do porto, 1000', cep: '20000-000', description: 'Galpao do Rio')
    supplier1 = Supplier.create!(corporate_name:'ACME LTDA', brand_name: 'ACME', registration_number: '2345678912',
                                full_address: 'Av das Ubaias, 50', city: 'Bauru', state: 'SP',
                                email: 'contato@acme.com')
    supplier2 = Supplier.create!(corporate_name:'Ponyo Brasil', brand_name: 'Ponyo', registration_number: '2349868912',
                                full_address: 'Rua Amelia, 500', city: 'Recife', state: 'PE',
                                email: 'contato@ponyo.com')
    order1 = Order.create(user: beatriz, warehouse: warehouse, supplier: supplier1,
                          estimated_delivery_date: 1.day.from_now )

    login_as(beatriz)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order1.code
    click_on 'Editar'
    fill_in 'Data estimada de entrega', with: '12/12/2023'
    select 'Ponyo Brasil', from: 'Fornecedor'
    click_on 'Salvar'

    expect(page).to have_content 'Pedido atualizado com sucesso'
    expect(page).to have_content 'Data estimada de entrega: 12/12/2023'
    expect(page).to have_content 'Fornecedor: Ponyo Brasil'
  end

  it 'caso seja o responsável' do
    beatriz = User.create!(name:'Beatriz', email: 'beatriz@email.com', password: 'password')
    gabriel = User.create!(name:'Gabriel', email: 'gabriel@email.com', password: 'password')
    warehouse = Warehouse.create(name: 'Rio', code:'SDU', city: 'Rio de Janeiro', area: 60_000,
                                address: 'Av do porto, 1000', cep: '20000-000', description: 'Galpao do Rio')
    supplier = Supplier.create!(corporate_name:'ACME LTDA', brand_name: 'ACME', registration_number: '2345678912',
                                full_address: 'Av das Ubaias, 50', city: 'Bauru', state: 'SP',
                                email: 'contato@acme.com')
    order1 = Order.create(user: beatriz, warehouse: warehouse, supplier: supplier,
                          estimated_delivery_date: 1.day.from_now )

    login_as(gabriel)
    visit edit_order_path(order1.id)

    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não possui acesso a este pedido'
  end

end

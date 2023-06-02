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
                          estimated_delivery_date: 1.day.from_now )
    order2 = Order.create(user: gabriel, warehouse: warehouse, supplier: supplier,
                          estimated_delivery_date: 1.day.from_now )
    order3 = Order.create(user: beatriz, warehouse: warehouse, supplier: supplier,
                          estimated_delivery_date: 1.week.from_now )

    login_as(beatriz)
    visit(root_path)
    click_on 'Meus Pedidos'

    expect(page).to have_content order1.code
    expect(page).not_to have_content order2.code
    expect(page).to have_content order3.code



  end
end

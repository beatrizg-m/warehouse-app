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
end

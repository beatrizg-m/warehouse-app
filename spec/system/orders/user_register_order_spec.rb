require 'rails_helper'

describe 'Usúario faz um pedido' do
  it 'e deve estar autenticado' do
    visit root_path
    click_on 'Registrar Pedido'

    expect(current_path).to eq new_user_session_path
  end

  it 'através da página de registro de pedido' do
    user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')

    login_as(user)
    visit root_path
    click_on 'Registrar Pedido'

    expect(page).to have_content 'Registre seu pedido'
  end

  it 'e não informa a data de entrega' do
    user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')
    warehouse = Warehouse.create(name: 'Rio', code:'SDU', city: 'Rio de Janeiro', area: 60_000,
      address: 'Av do porto, 1000', cep: '20000-000', description: 'Galpao do Rio')
    supplier = Supplier.create!(corporate_name:'ACME LTDA', brand_name: 'ACME', registration_number: '2345678912',
      full_address: 'Av das Ubaias, 50', city: 'Bauru', state: 'SP',
      email: 'contato@acme.com')


    login_as(user)
    visit root_path
    click_on 'Registrar Pedido'
    select 'SDU | Rio', from: 'Galpão Destino'
    select supplier.corporate_name, from: 'Fornecedor'
    fill_in 'Data estimada de entrega', with: ''
    click_on 'Salvar'

    expect(page).to have_content 'Não foi possivel registrar o pedido.'
    expect(page).not_to have_content 'Pedido registrado com sucesso.'

  end

  it 'com sucesso' do
    #Arrange
    user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')
    Warehouse.create(name: 'Maceio', code:'MCZ', city: 'Maceio', area: 50_000, address: 'Av Atlantica, 50',
                    cep: '80000-000', description: 'Perto do Aeroporto')
    warehouse = Warehouse.create(name: 'Rio', code:'SDU', city: 'Rio de Janeiro', area: 60_000,
                                  address: 'Av do porto, 1000', cep: '20000-000', description: 'Galpao do Rio')

    Supplier.create!(corporate_name:'Ponyo Industria Brasil', brand_name: 'Ponyo', registration_number: '2000078912', full_address: 'Av do mar, 150', city:  'Recife', state: 'PE', email: 'ponyobrasil@gmail.com')

    supplier = Supplier.create!(corporate_name:'ACME LTDA', brand_name: 'ACME', registration_number: '2345678912',
                                full_address: 'Av das Ubaias, 50', city: 'Bauru', state: 'SP',
                                email: 'contato@acme.com')

    allow(SecureRandom).to receive(:alphanumeric).and_return('ABC12345')

    #Act
    login_as(user)
    visit root_path
    click_on 'Registrar Pedido'
    select 'SDU | Rio', from: 'Galpão Destino'
    select supplier.corporate_name, from: 'Fornecedor'
    fill_in 'Data estimada de entrega', with: '20/12/2024'
    click_on 'Salvar'
    #Assert
    expect(page).to have_content 'Pedido registrado com sucesso.'
    expect(page).to have_content 'Pedido ABC12345'
    expect(page).to have_content 'Usuário Responsável: Joao - joao@email.com'
    expect(page).to have_content 'Galpão Destino: SDU | Rio'
    expect(page).to have_content 'Fornecedor: ACME LTDA | 2345678912'
    expect(page).to have_content 'Situação do Pedido: Pendente'
    expect(page).to have_content "Data estimada de entrega: 20/12/2024"
    expect(page).not_to have_content 'Ponyo Industria Brasil'
    expect(page).not_to have_content 'Maceio'
  end

end

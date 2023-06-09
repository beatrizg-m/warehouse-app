require 'rails_helper'

describe 'usuário cadastra um modelo de produto' do
  it 'com sucesso' do
    #Arrange
    user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')
    supplier = Supplier.create!(corporate_name: 'Samsung LTDA', brand_name: 'Samsung',
                    registration_number: '1234567787456', full_address: 'Av nacoes Unidas, 1000',
                    city: 'São Palo', state: 'SP', email: 'sac@samsung.com')
    #Act
    login_as(user)
    visit root_path
    click_on 'Modelos de Produtos'
    click_on 'Cadastrar novo'

    fill_in 'Nome', with: 'TV 40 polegadas'
    fill_in 'Peso', with: 10_000
    fill_in 'Altura', with: 60
    fill_in 'Largura', with: 90
    fill_in 'Profundidade', with: 10
    fill_in 'SKU', with: 'TV40-SAMS-PTXO0'
    select 'Samsung', from: 'Fornecedor'

    click_on 'Enviar'
    #Assert
    expect(page).to have_content 'Modelo de produto cadastrado com sucesso'
    expect(page).to have_content 'TV 40 polegadas'
    expect(page).to have_content 'SKU: TV40-SAMS-PTXO0'
    expect(page).to have_content 'Dimensões: 60cm X 90cm X 10cm'
    expect(page).to have_content 'Peso: 10000g'
    expect(page).to have_content 'Fornecedor: Samsung'
  end

end

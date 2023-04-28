require 'rails_helper'

describe 'usuário entra na página de fornecedores' do
  it 'e vê todos os fornecedores registrados' do
    #Arrange
    supplier_one = Supplier.create!(corporate_name:'ACME LTDA', brand_name: 'ACME', registration_number: '2345678912', full_address: 'Av das Ubaias, 50', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
    supplier_two = Supplier.create!(corporate_name:'Ponyo Industria Brasil', brand_name: 'Ponyo', registration_number: '2000078912', full_address: 'Av do mar, 150', city:  'Recife', state: 'PE', email: 'ponyobrasil@gmail.com')
    #Act
    visit root_path
    click_on 'Fornecedores'
    #Assert
    expect(current_path).to eq(suppliers_path)
    expect(page).to have_content 'Fornecedor: ACME'
    expect(page).to have_content 'Número de registro: 2345678912'
    expect(page).to have_content 'Fornecedor: Ponyo'
    expect(page).to have_content 'Número de registro: 2000078912'
  end

  it 'e volta para a página inicial' do
  #Arrange
  #Act
  visit root_path
  click_on 'Fornecedores'
  click_on 'Voltar'
  #Assert
  expect(current_path).to eq root_path
  end

  it 'e não existem fornecedores cadastrados' do
    #Arrange
    #Act
    visit root_path
    click_on 'Fornecedores'
    #Assert
    expect(page).to have_content 'Não existem fornecedores cadastrados'
  end
end

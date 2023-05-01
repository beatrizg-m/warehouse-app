require 'rails_helper'

describe 'usuário edita um fornecedor' do

  it 'a partir da tela de detalhes' do
    #Arrange
    supplier = Supplier.create!(corporate_name:'ACME LTDA', brand_name: 'ACME', registration_number: '2345678912', full_address: 'Av das Ubaias, 50',
                                    city: 'Bauru', state: 'SP', email: 'contato@acme.com')
    #Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'ACME'
    click_on 'Editar'
    #Assert
    expect(page).to have_content('Editar Fornecedor')
    expect(page).to have_field('Nome Corporativo', with: 'ACME LTDA')
    expect(page).to have_field('Nome Fantasia', with: 'ACME')
    expect(page).to have_field('Endereço Completo', with: 'Av das Ubaias, 50')
    expect(page).to have_field('Número de Registro', with: '2345678912')
    expect(page).to have_field('Cidade', with: 'Bauru')
    expect(page).to have_field('Estado', with: 'SP')
    expect(page).to have_field('Email', with: 'contato@acme.com')
  end

  it 'com sucesso' do
    supplier = Supplier.create!(corporate_name:'ACME LTDA', brand_name: 'ACME', registration_number: '2345678912', full_address: 'Av das Ubaias, 50',
                                city: 'Bauru', state: 'SP', email: 'contato@acme.com')

    visit root_path
    click_on 'Fornecedores'
    click_on 'ACME'
    click_on 'Editar'
    fill_in 'Nome Corporativo', with: 'Ponyo Brasil LTDA'
    fill_in 'Nome Fantasia', with: 'Ponyo'
    fill_in 'Número de Registro', with: '1234565478902'
    fill_in 'Endereço Completo', with: 'Avenida do mar, 1000'
    fill_in 'Cidade', with: 'Recife'
    fill_in 'Estado', with: 'PE'
    fill_in 'Email', with: 'ponyo.contato@yahoo.com'
    click_on 'Enviar'

    expect(page).to have_content 'Fornecedor atualizado com sucesso'
    expect(page).to have_content 'Ponyo Brasil LTDA'
    expect(page).to have_content '1234565478902'
  end

  it 'mas deixa um campo em branco' do
    supplier = Supplier.create!(corporate_name:'ACME LTDA', brand_name: 'ACME', registration_number: '2345678912', full_address: 'Av das Ubaias, 50',
      city: 'Bauru', state: 'SP', email: 'contato@acme.com')

    visit root_path
    click_on 'Fornecedores'
    click_on 'ACME'
    click_on 'Editar'
    fill_in 'Nome Corporativo', with: ''
    fill_in 'Nome Fantasia', with: 'Ponyo'
    fill_in 'Número de Registro', with: '1234565478902'
    fill_in 'Endereço Completo', with: 'Avenida do mar, 1000'
    fill_in 'Cidade', with: 'Recife'
    fill_in 'Estado', with: 'PE'
    fill_in 'Email', with: 'ponyo.contato@yahoo.com'
    click_on 'Enviar'

    expect(page).to have_content 'Fornecedor não atualizado'
  end
end

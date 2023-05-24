require 'rails_helper'

describe 'Usuario cadastra um fornecedor' do
  it 'atraves da tela de fornecedores' do
    #Arrange
    #Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar Fornecedor'
    #Assert
    expect(current_path).to eq new_supplier_path
    expect(page).to have_field 'Nome Corporativo'
    expect(page).to have_field 'Nome Fantasia'
    expect(page).to have_field 'Número de Registro'
    expect(page).to have_field 'Endereço Completo'
    expect(page).to have_field 'Cidade'
    expect(page).to have_field 'Estado'
    expect(page).to have_field 'Email'
  end

  it 'cadastra um fornecedor com sucesso' do
    #Arrange

    #Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar Fornecedor'
    fill_in 'Nome Corporativo', with: 'Ponyo Brasil LTDA'
    fill_in 'Nome Fantasia', with: 'Ponyo'
    fill_in 'Número de Registro', with: '1234565478902'
    fill_in 'Endereço Completo', with: 'Avenida do mar, 1000'
    fill_in 'Cidade', with: 'Recife'
    fill_in 'Estado', with: 'PE'
    fill_in 'Email', with: 'ponyo.contato@yahoo.com'
    click_on 'Enviar'

    #Assert
    expect(current_path).to eq "/suppliers/1"
    expect(page).to have_content 'Detalhes do Fornecedor Ponyo'
    expect(page).to have_content 'Fornecedor cadastrado com sucesso'
    expect(page).to have_content 'Nome Corporativo e CNPJ: Ponyo Brasil LTDA | 1234565478902'
    expect(page).to have_content 'Nome Fantasia: Ponyo'
    expect(page).to have_content 'Endereço Completo: Avenida do mar, 1000'
    expect(page).to have_content 'Cidade: Recife'
    expect(page).to have_content 'Estado: PE'
    expect(page).to have_content 'Email: ponyo.contato@yahoo.com'
  end

  it 'E falha por não preencher todos os campos' do
    #Arrange

    #Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar Fornecedor'
    fill_in 'Nome Corporativo', with: ''
    fill_in 'Nome Fantasia', with: 'Ponyo'
    fill_in 'Número de Registro', with: '1234565478902'
    fill_in 'Endereço Completo', with: ''
    fill_in 'Cidade', with: 'Recife'
    fill_in 'Estado', with: ''
    fill_in 'Email', with: 'ponyo.contato@yahoo.com'
    click_on 'Enviar'

    #Assert
    expect(page).to have_content 'Fornecedor não cadastrado'

  end
end

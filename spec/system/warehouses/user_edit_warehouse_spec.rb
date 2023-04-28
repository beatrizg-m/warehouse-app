require 'rails_helper'

describe 'Usuário edita um galpão' do
  it 'a partir da tela de detalhes' do
    #Arrange
    warehouse = Warehouse.create!(name: 'Rio', code:'SDU', city: 'Rio de Janeiro', area: 60_000,
                                address: 'Av do porto, 1000', cep: '20000-000',
                                description: 'Galpao do Rio')
    #Act
    visit root_path
    click_on 'Rio'
    click_on 'Editar'
    #Assert
    expect(page).to have_content('Editar Galpão')
    expect(page).to have_field('Nome', with: 'Rio')
    expect(page).to have_field('Descrição', with: 'Galpao do Rio')
    expect(page).to have_field('Código', with: 'SDU')
    expect(page).to have_field('Endereço', with: 'Av do porto, 1000')
    expect(page).to have_field('Cidade', with: 'Rio de Janeiro')
    expect(page).to have_field('CEP', with: '20000-000')
    expect(page).to have_field('Área', with: '60000')
  end

  it 'com sucesso' do
     #Arrange
     warehouse = Warehouse.create!(name: 'Rio', code:'SDU', city: 'Rio de Janeiro', area: 60_000,
      address: 'Av do porto, 1000', cep: '20000-000',
      description: 'Galpao do Rio')
    #Act
    visit root_path
    click_on 'Rio'
    click_on 'Editar'
    fill_in 'Nome', with: 'Galpão do Recife'
    fill_in 'Descrição', with: 'Galpão do porto'
    fill_in 'Código', with: 'RCF'
    fill_in 'Cidade', with: 'Recife'
    fill_in 'Área', with: '200000'
    fill_in 'CEP', with: '30200-200'
    fill_in 'Endereço', with: 'Av Agamenom magalhaes, 103'
    click_on 'Enviar'
    #Assert
    expect(page).to have_content('Galpão atualizado com sucesso')
    expect(page).to have_content('Nome: Galpão do Recife')
    expect(page).to have_content('Descricao: Galpão do porto')
    expect(page).to have_content('Galpao RCF')
    expect(page).to have_content('Endereco: Av Agamenom magalhaes, 103')
    expect(page).to have_content('Cidade: Recife')
    expect(page).to have_content('CEP: 30200-200')
    expect(page).to have_content('Area: 200000')
  end

  it 'e mantém os campos obrigatórios'  do
    #Arrange
    warehouse = Warehouse.create!(name: 'Rio', code:'SDU', city: 'Rio de Janeiro', area: 60_000,
      address: 'Av do porto, 1000', cep: '20000-000',
      description: 'Galpao do Rio')
    #Act
    visit root_path
    click_on 'Rio'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: 'Galpão do porto'
    fill_in 'Código', with: ''
    fill_in 'Cidade', with: 'Recife'
    click_on 'Enviar'
    #Assert
    expect(page).to have_content('Não foi possível atualizar o galpão')
  end
end

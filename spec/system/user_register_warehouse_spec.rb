require 'rails_helper'

describe 'usuario cadastra um galpao' do
  it 'a partir da tela inicial' do
    #Arrange

    #Act
    visit root_path
    click_on 'Cadastrar Galpao'
    #Assert
    expect(page).to have_field('Nome')
    expect(page).to have_field('Descricao')
    expect(page).to have_field('Codigo')
    expect(page).to have_field('Endereco')
    expect(page).to have_field('Cidade')
    expect(page).to have_field('CEP')
    expect(page).to have_field('Area')
  end

  it 'com sucesso' do
    #Arrange

    #Act
    visit root_path
    click_on 'Cadastrar Galpao'
    fill_in 'Nome', with: 'Rio de Janeiro'
    fill_in 'Descricao', with: 'Galpao da zona portuaria do Rio'
    fill_in 'Codigo', with: 'RIO'
    fill_in 'Endereco', with: 'Avenida do Museu do amanha, 1000'
    fill_in 'Cidade', with: 'Rio de Janeiro'
    fill_in 'CEP', with: '20100-000'
    fill_in 'Area', with: '32000'
    click_on 'Enviar'

    #Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpao cadastrado com sucesso.'
    expect(page).to have_content 'Rio de Janeiro'
    expect(page).to have_content 'RIO'
    expect(page).to have_content '32000 m2'
  end

  it 'com dados incompletos' do
    #Arrange

    #Act
    visit root_path
    click_on 'Cadastrar Galpao'
    fill_in 'Nome', with: ''
    fill_in 'Descricao', with: ''
    click_on 'Enviar'

    #Assert
    expect(page).to have_content 'Galpao nao cadastrado'
  end
end

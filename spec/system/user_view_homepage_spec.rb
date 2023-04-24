require 'rails_helper'

describe 'Usuario visita tela inicial' do
  it 'e ve o nome da app' do
    # Arrange
    #nesse caso nao temos arrange porque nao existe uma preparacao
    #aqui o usuario vai apenas abrir a pagina inicial, ele nao esta procurando algo
    #o arrange pode ficar vazio nesse caso

    #Act
    visit('/')

    #Assert
    expect(page).to have_content('Galpoes & Estoque')
  end

  it 'e ve os galpoes cadastrados' do
    #Arrange
    #cadastrar 2 galpoes: Rio e Maceio
    Warehouse.create(name: 'Rio', code:'SDU', city: 'Rio de Janeiro', area: 60_000)
    Warehouse.create(name: 'Maceio', code:'MCZ', city: 'Maceio', area: 50_000)
    #Act
    visit('/')

    #Assert
    #garantir que vejo na tela os 2 galpoes: Rio e Maceio
    #e neste caso, vamos ter vários expect porque temos varias funcionalidades, no caso queremos ver
    #nome, metragem, localidade e etc.
    expect(page).not_to have_content('Nao existem galpoes cadastrados')
    expect(page).to have_content('Rio')
    expect(page).to have_content('Codígo: SDU')
    expect(page).to have_content('Cidade: Rio de Janeiro')
    expect(page).to have_content('60000 m2')

    expect(page).to have_content('Maceio')
    expect(page).to have_content('Codígo: MCZ')
    expect(page).to have_content('Cidade: Maceio')
    expect(page).to have_content('50000 m2')
  end

  it 'e nao existem galpoes cadastrados' do
    #Arrange

    #Act
    visit('/')
    #Assert
    expect(page).to have_content('Nao existem galpoes cadastrados')
  end

end
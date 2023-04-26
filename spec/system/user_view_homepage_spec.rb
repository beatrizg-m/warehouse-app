require 'rails_helper'

describe 'Usuario visita tela inicial' do
  it 'e ve o nome da app' do
    # Arrange
    #Act
    visit(root_path)
    #Assert
    expect(page).to have_content('Galpoes & Estoque')
  end

  it 'e ve os galpoes cadastrados' do
    #Arrange
    Warehouse.create(name: 'Rio', code:'SDU', city: 'Rio de Janeiro', area: 60_000,
                    address: 'Av do porto, 1000', cep: '20000-000', description: 'Galpao do Rio')
    Warehouse.create(name: 'Maceio', code:'MCZ', city: 'Maceio', area: 50_000,
                    address: 'Av Atlantica, 50', cep: '80000-000', description: 'Perto do Aeroporto')
    #Act
    visit(root_path)
    #Assert
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
    visit(root_path)
    #Assert
    expect(page).to have_content('Nao existem galpoes cadastrados')
  end

end

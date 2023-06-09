require "rails_helper"

describe 'Usuario ve detalhe de um galpao ' do
  it ' e ve informacoes adicionais' do
    Warehouse.create(name: 'Aeroporto SP', code: 'GRU',
                      city: 'Guarulhos',
                      area: 100_000,
                      address: 'Avenida do aeroporto, 1000', cep: '12234-000',
                      description: 'Galpao destinado para cargas internacionais')

    #Act
    visit(root_path)
    click_on('Aeroporto SP')

    #Assert
    expect(page).to have_content('Galpao GRU')
    expect(page).to have_content('Nome: Aeroporto SP')
    expect(page).to have_content('Cidade: Guarulhos')
    expect(page).to have_content('Area: 100000')
    expect(page).to have_content('Endereco: Avenida do aeroporto, 1000')
    expect(page).to have_content('CEP: 12234-000')
    expect(page).to have_content('Descricao: Galpao destinado para cargas internacionais')
  end

  it 'e volta para a tela inicial' do
    #Arrange
    Warehouse.create(name: 'Aeroporto SP', code: 'GRU',
      city: 'Guarulhos',
      area: 100_000,
      address: 'Avenida do aeroporto, 1000', cep: '12234-000',
      description: 'Galpao destinado para cargas internacionais')
    #Act
    visit(root_path)
    click_on('Aeroporto SP')
    click_on('Voltar')
    #Assert
    expect(current_path).to eq(root_path)
  end
end

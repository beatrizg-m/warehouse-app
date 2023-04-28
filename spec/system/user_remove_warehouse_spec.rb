require 'rails_helper'

describe 'Usuário remove um galpão' do
  it 'com sucesso' do
    #Arrange
    Warehouse.create!(name: 'Rio', code:'SDU', city: 'Rio de Janeiro', area: 60_000,
                    address: 'Av do porto, 1000', cep: '20000-000',
                    description: 'Galpao do Rio')
    #Act
      visit root_path
      click_on 'Rio'
      click_on 'Remover'
      click_on 'Confirmar'
    #Assert
      expect(current_path).to eq root_path
      expect(page).to have_content 'Galpão removido com sucesso'
      expect(page).not_to have_content 'Rio'
      expect(page).not_to have_content 'SDU'
  end

  it 'e não apaga outros galpões' do
    #Arrange
    first_warehouse = Warehouse.create!(name: 'Rio', code:'SDU', city: 'Rio de Janeiro', area: 60_000,
                                        address: 'Av do porto, 1000', cep: '20000-000',
                                        description: 'Galpao do Rio')
    second_warehouse = Warehouse.create!(name: 'Belo Horizonte', code:'BHZ', city: 'Belo Horizonte', area: 20_000,
                                        address: 'Av. Tiradentes, 20', cep: '20000-000',
                                        description: 'Galpão para cargas mineiras')
    #Act
    visit root_path
    click_on 'Rio'
    click_on 'Remover'
    click_on 'Confirmar'
    #Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão removido com sucesso'
    expect(page).to have_content 'Belo Horizonte'
    expect(page).not_to have_content 'Rio'
  end

  it 'e confirma a exclusão' do
    #Arrange
    first_warehouse = Warehouse.create!(name: 'Rio', code:'SDU', city: 'Rio de Janeiro', area: 60_000,
                                        address: 'Av do porto, 1000', cep: '20000-000',
                                        description: 'Galpao do Rio')
    #Act
    visit root_path
    click_on 'Rio'
    click_on 'Remover'
    click_on 'Confirmar'
    #Assert
    expect(current_path).to eq root_path
  end


end

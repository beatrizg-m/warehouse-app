require 'rails_helper'

describe 'usuário entra na página de fornecedores' do
  it 'e vê todos os fornecedores' do
    #Arrange

    #Act
    visit root_path
    click_on 'Fornecedores'
    #Assert
    expect(current_path).to eq(suppliers_path)
  end
end

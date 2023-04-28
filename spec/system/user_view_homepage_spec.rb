require 'rails_helper'

describe 'Usuario visita tela inicial' do
  it 'e ve o nome da app' do
    # Arrange
    #Act
    visit(root_path)
    #Assert
    expect(page).to have_content('Galpoes & Estoque')
  end
end

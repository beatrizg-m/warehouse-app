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

end

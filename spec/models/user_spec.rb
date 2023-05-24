require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#description' do
    it 'exibe o nome e o email' do
      u = User.new(name: 'Juliana', email: 'juliana@email.com')

      result = u.description

      expect(result).to eq('Juliana - juliana@email.com')
    end
  end
end

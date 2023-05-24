require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe '#full_dimensions' do
    it 'exibe todas as dimensões juntas' do
      pm = ProductModel.new(height: 30, width: 40, depth: 30)

      result = pm.full_dimensions

      expect(result).to eq('30cm X 40cm X 30cm')
    end

  end
end

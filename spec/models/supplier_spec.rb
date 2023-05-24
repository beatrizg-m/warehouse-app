require 'rails_helper'

RSpec.describe Supplier, type: :model do

  describe '#valid?' do
    it 'false when corporate_name is empty' do
       #Arrange
        supplier = Supplier.new(corporate_name:'', brand_name: 'ACME', registration_number: '2345678912',
                          full_address: 'Av das Ubaias, 50', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
       #Act
       #Assert
       expect(supplier.valid?).to eq false
    end

    it 'false when brand_name is empty' do
      #Arrange
       supplier = Supplier.new(corporate_name:'ACME LTDA', brand_name: '', registration_number: '2345678912',
                         full_address: 'Av das Ubaias, 50', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
      #Act
      #Assert
      expect(supplier.valid?).to eq false
    end

    it 'false when registration_number is empty' do
      #Arrange
       supplier = Supplier.new(corporate_name:'ACME LTDA', brand_name: 'ACME', registration_number: '',
                         full_address: 'Av das Ubaias, 50', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
      #Act
      #Assert
      expect(supplier.valid?).to eq false
    end

    it 'false when full_address is empty' do
      #Arrange
       supplier = Supplier.new(corporate_name:'ACME LTDA', brand_name: 'ACME', registration_number: '2345678912',
                         full_address: '', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
      #Act
      #Assert
      expect(supplier.valid?).to eq false
    end

    it 'false when city is empty' do
      #Arrange
       supplier = Supplier.new(corporate_name:'ACME LTDA', brand_name: 'ACME', registration_number: '2345678912',
                         full_address: 'Av das Ubaias, 50', city: '', state: 'SP', email: 'contato@acme.com')
      #Act
      #Assert
      expect(supplier.valid?).to eq false
    end

    it 'false when state is empty' do
      #Arrange
       supplier = Supplier.new(corporate_name:'ACME LTDA', brand_name: 'ACME', registration_number: '2345678912',
                         full_address: 'Av das Ubaias, 50', city: 'Bauru', state: '', email: 'contato@acme.com')
      #Act
      #Assert
      expect(supplier.valid?).to eq false
    end

    it 'false when email is empty' do
      #Arrange
       supplier = Supplier.new(corporate_name:'ACME LTDA', brand_name: 'ACME', registration_number: '2345678912',
                         full_address: 'Av das Ubaias, 50', city: 'Bauru', state: 'SP', email: '')
      #Act
      #Assert
      expect(supplier.valid?).to eq false
    end

  end

  describe 'full_register' do
    it 'visualiza o nome e o cnpj juntos' do
      s = Supplier.new(corporate_name: 'ACME', registration_number: '2345678912')

      result = s.full_register

      expect(result).to eq('ACME | 2345678912')
    end

  end

end

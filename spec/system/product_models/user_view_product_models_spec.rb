require 'rails_helper'

describe 'Usuário vê modelos de prdutos' do
  it 'a partir do menu' do
    visit root_path
    within('nav') do
      click_on 'Modelos de Produtos'
    end

    expect(current_path).to eq product_models_path
    expect(page).to have_content 'Modelos de Produtos'
  end

  it 'com sucesso' do
    supplier = Supplier.create!(corporate_name: 'Samsung LTDA', brand_name: 'Samsung',
                                registration_number: '1234567787456', full_address: 'Av nacoes Unidas, 1000',
                                city: 'São Palo', state: 'SP', email: 'sac@samsung.com')
    ProductModel.create!(name:'TV-32', weight: 8000, width: 70, height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO90',
                        supplier: supplier)
    ProductModel.create!(name:'SoundBar 7.1', weight: 3000, width: 80, height: 15, depth: 20, sku: 'SOU71-SAMSU-NOI99',
                        supplier: supplier)

    visit root_path
    within('nav') do
      click_on 'Modelos de Produtos'
    end

    expect(page).to have_content 'TV-32'
    expect(page).to have_content 'TV32-SAMSU-XPTO90'
    expect(page).to have_content 'Samsung'
    expect(page).to have_content 'SoundBar 7.1'
    expect(page).to have_content 'SOU71-SAMSU-NOI99'
    expect(page).to have_content 'Samsung'

  end

end

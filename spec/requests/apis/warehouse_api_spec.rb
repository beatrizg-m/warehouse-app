require 'rails_helper'

describe 'Warehouse API' do
  context 'GET /api/v1/warehouses/1' do
    it 'sucess' do
      warehouse = Warehouse.create!(name: 'Rio', code:'SDU', city: 'Rio de Janeiro', area: 60_000,
        address: 'Av do porto, 1000', cep: '20000-000', description: 'Galpao do Rio')

      get "/api/v1/warehouses/#{warehouse.id}"

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'

      json_response = JSON.parse(response.body)
      expect(json_response['name']).to eq('Rio')
      expect(json_response['code']).to eq('SDU')
      expect(json_response['city']).to eq('Rio de Janeiro')
      expect(json_response['cep']).to eq('20000-000')
      expect(json_response.keys).not_to include('created_at')
      expect(json_response.keys).not_to include('updated_at')

    end

    it 'fail if warehouse not found' do
      get "/api/v1/warehouses/999999"

      expect(response.status).to eq 404
    end

  end

  context 'GET /api/v1/warehouses' do
    it 'list all warehouses ordered by name' do
      Warehouse.create!(name: 'Rio', code:'SDU', city: 'Rio de Janeiro', area: 60_000,
        address: 'Av do porto, 1000', cep: '20000-000', description: 'Galpao do Rio')
      Warehouse.create!(name: 'Maceio', code:'MCZ', city: 'Maceio', area: 50_000,
        address: 'Av Atlantica, 50', cep: '80000-000', description: 'Perto do Aeroporto')

      get "/api/v1/warehouses"

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 2
      expect(json_response.class).to eq Array
      expect(json_response[0]['name']).to eq 'Maceio'
      expect(json_response[1]['name']).to eq 'Rio'
    end

    it 'return empty if there is no warehouse' do
      get "/api/v1/warehouses"

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response).to eq []
    end

  end

  context 'POST /api/vi/warehouses' do
    it 'sucess' do
      warehouse_params = { warehouse: { name: 'Rio', code:'SDU', city: 'Rio de Janeiro', area: 60_000,
        address: 'Av do porto, 1000', cep: '20000-000', description: 'Galpão do Rio'} }

      post '/api/v1/warehouses', params: warehouse_params

      expect(response).to have_http_status(201)
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response['name']).to eq('Rio')
      expect(json_response['code']).to eq('SDU')
      expect(json_response['city']).to eq('Rio de Janeiro')
      expect(json_response['area']).to eq(60_000)
      expect(json_response['address']).to eq('Av do porto, 1000')
      expect(json_response['cep']).to eq('20000-000')
      expect(json_response['description']).to eq('Galpão do Rio')
    end

    it 'fail if parameters are not complete' do
      warehouse_params = { warehouse: {name: 'Aeroporto de Recife', city: 'Recife'}}

      post '/api/v1/warehouses', params: warehouse_params

      expect(response).to have_http_status(412)
      expect(response.body).to include('Código não pode ficar em branco')
      expect(response.body).to include('Área não pode ficar em branco')
      expect(response.body).to include('Descrição não pode ficar em branco')
      expect(response.body).to include('CEP não pode ficar em branco')
      expect(response.body).not_to include('Nome não pode ficar em branco')

    end
  end

end

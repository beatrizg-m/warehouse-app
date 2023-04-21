require "rails_helper"

describe 'Usuario ve detalhe de um galpao ' do
  it ' e ve informacoes adicionais' do
    Warehouse.create(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area:100_000,
                      address: 'Avenida do aeroporto, 1000', CEP: '12234-000',
                      description: 'Galpao destinado para cargas internacionais')

    #Act

  end
end

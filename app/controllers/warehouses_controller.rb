class WarehousesController < ApplicationController

    def show
        @warehouse = Warehouse.find(params[:id])
    end

    def new
        @warehouse = Warehouse.new
    end

    def create
        warehouse_params = params.require(:warehouse).permit(:name, :code, :city, :description,
                                                            :address, :cep, :area)

        @warehouse = Warehouse.new(warehouse_params)
        if @warehouse.save()
            redirect_to root_path, notice: 'Galpao cadastrado com sucesso.'
        else
            flash.now[:notice] = 'Galpao nao cadastrado'
            render 'new'
        end

    end
end

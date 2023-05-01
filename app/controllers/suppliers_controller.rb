class SuppliersController < ApplicationController

  def index
    @suppliers = Supplier.all
    if @suppliers.empty?
      flash[:notice] = 'Não existem fornecedores cadastrados'
    end
  end

  def new
    @supplier = Supplier.new
  end

  def create
    supplier_params = params.require(:supplier).permit(:corporate_name, :brand_name, :registration_number, :full_address, :city, :state, :email)

    @supplier = Supplier.new(supplier_params)

    if @supplier.save()
      redirect_to supplier_path(@supplier.id), notice: 'Fornecedor cadastrado com sucesso'
    else
      flash.now[:notice] = 'Fornecedor não cadastrado'
      render 'new'
    end

  end

  def show
    @supplier = Supplier.find(params[:id])
  end
end

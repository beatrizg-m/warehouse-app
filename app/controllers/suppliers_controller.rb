class SuppliersController < ApplicationController

  def index
    @suppliers = Supplier.all
    if @suppliers.empty?
      flash[:notice] = 'Não existem fornecedores cadastrados'
    end
  end
end

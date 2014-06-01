class CommentersController < ApplicationController

  def create
    @commenter = Commenter.new(commenter_params)

    if @commenter.save
      redirect_to root_url
    else
      redirect_to root_url
    end
  end

  private
  def commenter_params
    params.require(:commenter).permit(:name, :email, :address_line_1, :zip, :comment)
  end
end

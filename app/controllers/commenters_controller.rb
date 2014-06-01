class CommentersController < ApplicationController

  def create
    @commenter = Commenter.new(commenter_params)

    if @commenter.save
      Resque.enqueue(PostToFccJob, @commenter.id)
      redirect_to root_url, flash: { success: "Thank you for submitting your comments."}
    else
      redirect_to root_url, error: "There was an error submitting your comment."
    end
  end

  private
  def commenter_params
    params.require(:commenter).permit(:name, :email, :address_line_1, :zip, :comment)
  end
end

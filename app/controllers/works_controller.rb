class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def new
    @work = Work.new 
  end

  def create
    @work = Work.new(work_params) 
    if @work.save 
      flash[:success] = "#{@work.title} added successfully"
      redirect_to work_path(@work.id)
      return
    else
      flash.now[:error] = "Something happened. #{@work.title} was not added."
      render :new, status: :bad_request
      return
    end
  end

  private

  def work_params
    return params.require(:work).permit(:title, :category, :creator, :description, :publication_year)
  end

end

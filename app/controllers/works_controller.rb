class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]

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

  def show
    if @work.nil?
      head :not_found
      return
    end
  end

  def edit
    if @work.nil?
      head :not_found
      return
    end
  end

  def update
    if @work.nil?
      flash[:warning] = "This work does not exist"
      head :not_found
      return 
    elsif @work.update(
      title: params[:work][:title],
      category: params[:work][:category],
      creator: params[:work][:creator],
      description: params[:work][:description],
      publication_year: params[:work][:publication_year]
    )
      flash[:success] = "Successfully updated #{@work.category} #{@work.id}"
      redirect_to work_path(@work.id)
      return
    else
      flash[:warning] = "A problem occurred. Could not update #{@work.category}"
      render :edit
      return
    end
  end

  def destroy
    if @work.nil?
      flash[:warning] = "A problem occurred. This work does not exist"
      head :not_found
      return
    elsif @work.destroy
      flash[:success] = "Successfully deleted #{@work.category} #{@work.id}"
      redirect_to works_path
      return
    else
      flash[:warning] = "A problem occurred. Could not delete #{@work.category}"
      render :show
      return
    end
  end

  private

  def work_params
    return params.require(:work).permit(:title, :category, :creator, :description, :publication_year)
  end

  def find_work
    @work = Work.find_by(id: params[:id])
  end

end

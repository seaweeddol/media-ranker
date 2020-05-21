class VotesController < ApplicationController
  def create
    if session[:user_id]
      work = Work.find(params[:work_id])
      if work.votes.where(user_id: session[:user_id]) == []
        vote = Vote.create(work_id: params[:work_id], user_id: session[:user_id])
        flash[:success] = "Successfully upvoted!"
        redirect_to request.referrer
      else
        flash[:error] = "A problem occurred: Could not upvote"
        redirect_to request.referrer
      end
    else
      flash[:error] = "A problem occurred: You must log in to do that"
      redirect_to request.referrer
    end
  end
end

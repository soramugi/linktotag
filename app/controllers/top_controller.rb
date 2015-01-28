class TopController < ApplicationController
  def index
  end

  def tag
    type = params[:type] || 'tag'
    link = params[:link]

    render :json => 'hi'
  end
end

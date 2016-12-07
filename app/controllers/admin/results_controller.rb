class Admin::ResultsController < ApplicationController
  before_action :find_result, only: [:show]
  def index
    @results = Result.all
  end

  def show
  end

  private
    def find_result
      @result = Result.find_by_id(params[:id])
    end
end

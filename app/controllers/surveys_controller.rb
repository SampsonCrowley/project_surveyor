class SurveysController < ApplicationController
  before_action :find_survey, only: [:new, :show, :edit, :destroy, :update]

  def create
    @result = Result.new({survey_id: params[:survey_id], result: params[:survey]})
    if @result.save
      flash[:success]="Survey Submitted!"
      redirect_to survey_path(params[:survey_id])
    else
      flash[:danger]="Something went wrong, please fill in all required fields"
      render :new
    end
  end

  def index
    @surveys = Survey.all
  end

  def new
  end

  def show
  end

  private
    def find_survey
      @survey = Survey.find_by_id(params[:id])
    end
end

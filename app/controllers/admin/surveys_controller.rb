class Admin::SurveysController < ApplicationController
  before_action :find_survey, only: [:show, :edit, :destroy, :update]

  def create
    @survey = Survey.new(whitelisted)
    if @survey.save
      flash[:success] = %Q[Survey: <a href="#{admin_survey_path(@survey.id)}">#{@survey.title.capitalize}</a> created!]
      redirect_to new_admin_survey_question_path(@survey.id)
    else
      render :new
    end
  end

  def edit
  end

  def index
    @surveys = Survey.all
  end

  def new
    @survey = Survey.new
  end

  def show
  end

  def update
    if @survey.update(whitelisted)
      flash[:success] = %Q[Survey: <a href="#{admin_survey_path(@survey.id)}">#{@survey.title.capitalize}</a> Updated!]
      redirect_to new_admin_survey_question_path(@survey.id)
    else
      flash.now[:danger] = @survey.errors.full_messages
      render :edit
    end
  end

  private
    def find_survey
      @survey = Survey.find_by_id(params[:id])
    end

    def whitelisted
      params.require(:survey).permit(:title, :description, {
                                                              questions_attributes: [
                                                                :category_id,
                                                                :id,
                                                                :order
                                                              ]
                                                            })
    end
end

class QuestionsController < ApplicationController
  before_action :find_survey
  before_action :find_question, only: [:edit, :update]
  def new
    @question = @survey.questions.build
  end

  def create
    @question = @survey.questions.build(whitelisted)
    if @question.save
      flash[:success] = %Q[Question: <a href="#{survey_question_path(@survey, @question)}">New Question Created!</a> created!]
      redirect_to edit_survey_question_path(@survey, @question)
    else
      flash[:danger] = %Q[Question: not created!<br>#{@question.errors.full_messages.map {|m| m}}.join("<br>")]
      render :new
    end
  end

  def edit
    @set_text = (params.has_key?(:set_text) && params[:set_text] == "true")
    @options_count = (params.has_key?(:options_count) ? params[:options_count].to_i : nil)
  end

  def update
    if @question.update(whitelisted)
      flash[:success] = %Q[Question Options Set!]
      if params[:complete] == "true"
        MultipleChoice.reset_counters(@question.category_id, :options)
        redirect_to new_survey_question_path(@survey)
      else
        redirect_to edit_survey_question_path(@survey, @question, set_text: "true", options_count: params[:options_count])
      end
    else
      flash[:danger] = %Q[Question not updated..<br>#{@question.errors.full_messages.map {|m| m}}.join("<br>")]
      render :edit
    end
  end

  private
    def find_survey
      @survey = Survey.find_by_id(params[:survey_id])
    end

    def find_question
      @question = Question.find_by_id(params[:id])
    end

    def whitelisted
      params.require(:question).
             permit(
                      :category_type,
                      :category_id,
                      :order,
                      :question,
                      :required,
                      {
                        category_attributes: [
                          :id,
                          :multi,
                          {
                            options_attributes:[
                              :id,
                              :text,
                              :value,
                              :_destroy
                            ]
                          }
                        ]
                      }
                    )
    end
end

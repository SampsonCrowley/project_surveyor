module QuestionsHelper
  def render_partial_for_category(question)
    if @set_text
      if @options_count
        (@options_count).times do
          question.category.options.build
        end
      else
        question.category.options.build
      end
      render partial: "#{question.category_type.underscore}_text_form", locals: {question: question}
    else
      render partial: "#{question.category_type.underscore}_options_form", locals: {question: question}
    end
  end
end

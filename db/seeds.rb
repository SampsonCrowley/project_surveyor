# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
NUM_SURVEYS = 10

puts "creating surveys"
NUM_SURVEYS.times do
  Survey.create({
      title: Faker::StarWars.planet,
      description: Faker::Hipster.paragraph
    })
end

survey_ids = Survey.pluck(:id)
puts "creating questions and category rows"
survey_ids.each do |s_id|
  count = 0
  rand(5..10).times do
    count += 1
    Question.create({
        survey_id: s_id,
        category_type: (rand(0..9) > 5 ? "MultipleChoice" : "RangeChoice"),
        question: Faker::Hipster.sentence,
        order: count,
        required: (rand(0..9) > 5 ? true : false)
      })
  end
end
puts "creating Ranges"
range_ids = RangeChoice.pluck(:id)
range_ids.each do |r_id|
  RangeChoice.find_by_id(r_id).update(max: (rand(0..9) > 5 ? rand(0..100) : nil))
end

puts "creating Options"
multiple_ids = MultipleChoice.pluck(:id)
multiple_ids.each do |m_id|
  count = 0
  MultipleChoice.find_by_id(m_id).update(multi: (rand(0..9) > 5 ? true : false))
  rand(5..10).times do
    count += 1
    Option.create({
        multiple_choice_id: m_id,
        text: Faker::Hipster.sentence,
      })
  end
end

puts "seeding results"
10.times do
  s = Survey.find_by_id(survey_ids.sample)
  a = {}
  s.questions.each do |q|
    if q.category_type == "MultipleChoice"
      a[q.id] = q.category.option_ids.sample
    else
      a[q.id] = rand(q.category.min..(q.category.max || 100))
    end
  end
  Result.create({
    survey_id: s.id,
    result: a
    })

end

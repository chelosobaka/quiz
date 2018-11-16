require_relative "lib/question"
require_relative "lib/xml_reader"
if (Gem.win_platform?)
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end


require 'time'

collect = XmlReader.read # массив объектов Question.

sum_of_current_answers = 0 # счётчик правильных ответов.

collect.each_with_index do |question, index_of_question|
  # вывод вопроса.
  puts"#{index_of_question + 1}. #{question.text}"
  # вывод вариантов ответа.
  puts "Варианты:"
  question.variants.each_with_index do |variant, index_of_variant|
    puts " #{index_of_variant + 1}. #{variant}"
  end

  time_to_answer = Time.at(question.second.to_i).utc.strftime("%H:%M:%S") # перевод значения в формат времени.
  puts "У вас #{time_to_answer} на ответ:"
  # начало отсчёта
  start_time = Time.now
  input = STDIN.gets.to_i - 1
  # конец отсчёта
  end_time = Time.now
  timer = Time.at(end_time - start_time).utc.strftime("%H:%M:%S") # сколько понадобилось на ответ

  if timer <= time_to_answer # уложился ли во время
    if question.variants[input].to_i == question.good_variant.to_i # правильный ли ответ
      puts "Верно."
      sum_of_current_answers += 1
    else
      puts "Не верно. Правильный ответ #{question.good_variant}"
    end
  else
    puts "Вы не уложились в отведённое время."
  end
  puts
end

puts "Вы правильно ответили на #{sum_of_current_answers} вопросов."

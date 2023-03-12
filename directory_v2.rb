@students = []
require 'date'

def try_load_students
  filename = ARGV.first || 'students.csv'
  puts 'please load a correct file' unless File.exist?(filename)
  exit unless File.exist?(filename)
end

def interactive_menu
  loop do
    print_menu
    process_input(STDIN.gets.chomp) # chomp could be replaced by gsub("\n", "")
  end
end

def print_menu
  puts "\n1. Input the students"
  puts '2. Show the students'
  puts '3. Save the students list to students.csv'
  puts '4. Load the list from students.csv'
  puts '9. Exit'
end

def process_input(selection)
  case selection
  when '1'
    input_students
  when '2'
    show_students
  when '3'
    save_students
    puts 'List saved'
  when '4'
    load_students
    puts 'csv contents loaded into current list'
  when '9'
    exit
  else
    puts "I don't know what you meant, try again"
    p "you wrote #{selection}"
  end
end

def input_students
  puts 'Please enter the names of the students'
  puts "To finish, just hit enter on the student's name"
  name = STDIN.gets.chomp
  input_cohort(name)
end

def input_cohort(name)
  until name.empty?
    puts 'Now enter their cohort'
    @students << { name: name, cohort: get_month }
    puts "Now we have #{@students.length} student#{optional_plural}."
    name = STDIN.gets.chomp
  end
end

def get_month
  until Date::MONTHNAMES.include? cohort = STDIN.gets.chomp.capitalize
    puts 'Did you get the month right? Please reenter:'
  end
  cohort.to_sym
end

def show_students
  print_header if @students.count > 0
  print_students_list
  print_footer
end

def print_header
  puts "The student#{optional_plural} at Makers Academy"
  puts '-------------'
end

def print_students_list
  @students.each_with_index do |student, index|
    puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)" if student[:name].length < 12
  end
end

def print_footer
  puts "Overall, we have #{@students.length} great student#{optional_plural}"
end

def save_students
  file = File.open('students.csv', 'w')
  @students.each do |student|
    file.puts [student[:name], student[:cohort]].join(',')
  end
  file.close
end

def load_students(filename = 'students.csv')
  file = File.open(filename, 'r')
  file.readlines.each do |line|
    name, cohort = line.chomp.split(',')
    @students << { name: name, cohort: cohort.to_sym }
  end
  file.close
end

def optional_plural
  return 's' if @students.length != 1
end

try_load_students

interactive_menu

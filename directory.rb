def input_student
  puts 'Please enter the names of the students'
  puts 'To finish, please hit entere twice'

  students = []

  name = gets.chomp

  until name.empty?

    students << { name: name, cohort: :november }
    puts "Now we have #{students.count} students"

    name = gets.chomp
  end

  students
end

students = input_student
print_header
print(students)
print_footer(students)

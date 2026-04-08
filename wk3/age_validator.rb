# Simple Ruby CLI for Age Validation

def validate_age(input)
  begin
    age = Integer(input)
  rescue ArgumentError
    return "Invalid input: age must be a number."
  end

  if age < 18
    "Invalid: age must be at least 18."
  elsif age > 65
    "Invalid: age must be 65 or younger."
  else
    "Valid: eligible age."
  end
end

if __FILE__ == $0
  print "Enter your age: "
  user_input = gets.chomp
  puts validate_age(user_input)
end

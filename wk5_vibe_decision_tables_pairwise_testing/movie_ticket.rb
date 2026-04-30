# Movie Ticket Pricing Calculator
# Demonstrates Decision Tables and Pairwise Testing
# Test all combinations of: Age Group x Showtime x Membership Status

puts "================================"
puts "  MOVIE TICKET PRICE CALCULATOR  "
puts "================================\n"

# Define the valid input options for validation
VALID_AGE_GROUPS = ["child", "adult", "senior"]
VALID_SHOWTIMES = ["matinee", "evening"]
VALID_MEMBERSHIP = ["yes", "no"]

# Base ticket prices by age group (Decision Table Input 1)
BASE_PRICES = {
  "child" => 8,
  "adult" => 12,
  "senior" => 10
}

# Discount amounts (Decision Table Inputs 2 & 3 affect price)
MATINEE_DISCOUNT = 2
MEMBER_DISCOUNT = 1

# ===== Function to get and validate user input =====
def get_user_input(prompt, valid_options)
  loop do
    puts prompt
    user_input = gets.chomp.downcase

    if valid_options.include?(user_input)
      return user_input
    else
      puts "❌ Invalid input! Please enter one of: #{valid_options.join(", ")}\n\n"
    end
  end
end

# ===== Function to calculate the ticket price =====
def calculate_ticket_price(age_group, showtime, is_member)
  # Step 1: Get the base price based on age group
  price = BASE_PRICES[age_group]

  # Step 2: Apply matinee discount if applicable
  if showtime == "matinee"
    price -= MATINEE_DISCOUNT
  end

  # Step 3: Apply member discount if applicable
  if is_member == "yes"
    price -= MEMBER_DISCOUNT
  end

  # Ensure price doesn't go below $0
  [price, 0].max
end

# ===== Main program flow =====

# Collect user inputs with validation
age_group = get_user_input(
  "What is your age group? (child/adult/senior)",
  VALID_AGE_GROUPS
)

showtime = get_user_input(
  "What showtime do you prefer? (matinee/evening)",
  VALID_SHOWTIMES
)

is_member = get_user_input(
  "Are you a member? (yes/no)",
  VALID_MEMBERSHIP
)

# Calculate the final price
final_price = calculate_ticket_price(age_group, showtime, is_member)

# Display the results clearly
puts "\n================================"
puts "       YOUR TICKET DETAILS       "
puts "================================"
puts "Age Group:    #{age_group.capitalize}"
puts "Showtime:     #{showtime.capitalize}"
puts "Member:       #{is_member.capitalize}"
puts "--------------------------------"
puts "Final Price:  $#{final_price}"
puts "================================\n"

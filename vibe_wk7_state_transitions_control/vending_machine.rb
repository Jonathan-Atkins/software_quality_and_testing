#!/usr/bin/env ruby

# ============================================================================
# VENDING MACHINE - Simple Version for School Assignment
# Week 7: State Transitions, Control Flow Testing, Data Flow Testing
# ============================================================================

puts "=" * 50
puts "Welcome to the Vending Machine"
puts "=" * 50

# ========== STATE VARIABLE ==========
# CONTROL FLOW: Track the current state of the machine
state = "Idle"

# ========== DATA VARIABLES ==========
# DATA FLOW: These variables hold data that flows through the program
balance = 0.0           # Money inserted by user
item_choice = ""        # User's item selection
item_name = ""          # Name of selected item
item_price = 0.0        # Price of selected item
change = 0.0            # Change to return

# Define item prices
# DATA FLOW: Item data is stored in variables
soda_price = 2.00
chips_price = 3.00

# ========== STEP 1: INSERT MONEY ==========
# STATE TRANSITION: Idle -> Money Inserted

puts "\nPlease insert money:"
print "Enter amount in dollars: $"
money_input = gets.chomp

# CONTROL FLOW: Validate money input
if money_input.empty?
  state = "Error"
  puts "ERROR: Please enter an amount"
elsif money_input.to_f <= 0
  state = "Error"
  puts "ERROR: Amount must be positive"
else
  # DATA FLOW: Convert input string to number
  balance = money_input.to_f
  
  # STATE TRANSITION: Idle -> Money Inserted
  state = "Money Inserted"
  puts "OK: Inserted $#{balance.round(2)}"
end

# ========== STEP 2: SELECT ITEM ==========
# Only proceed if money insertion was successful
# CONTROL FLOW: Check current state

if state == "Money Inserted"
  # Display available items
  puts "\nSelect an item:"
  puts "1 - Soda      ($2.00)"
  puts "2 - Chips     ($3.00)"
  
  print "\nEnter choice (1 or 2): "
  item_choice = gets.chomp
  
  # CONTROL FLOW: Use case statement to handle item selection
  case item_choice
  when "1"
    # User selected Soda
    item_name = "Soda"
    item_price = soda_price
    
  when "2"
    # User selected Chips
    item_name = "Chips"
    item_price = chips_price
    
  else
    # Invalid selection
    state = "Error"
    puts "ERROR: Invalid selection (choose 1 or 2)"
  end
  
  # ========== STEP 3: CHECK FUNDS AND DISPENSE ==========
  # CONTROL FLOW: Check if we selected a valid item
  
  if state == "Money Inserted"
    # CONTROL FLOW: Check if enough money
    if balance >= item_price
      # STATE TRANSITION: Money Inserted -> Dispensing
      state = "Dispensing"
      puts "\nDispensing #{item_name}..."
      
      # STATE TRANSITION: Dispensing -> Complete
      state = "Complete"
      puts "OK: #{item_name} dispensed"
      
      # DATA FLOW: Calculate change
      change = balance - item_price
      
      # CONTROL FLOW: Check if change needs to be returned
      if change > 0
        puts "OK: Change is $#{change.round(2)}"
      else
        puts "OK: Exact amount - no change"
      end
      
      puts "OK: Thank you!"
      
    else
      # Not enough money
      state = "Error"
      shortage = item_price - balance
      puts "\nERROR: Insufficient funds"
      puts "ERROR: Need $#{shortage.round(2)} more for #{item_name}"
    end
  end
end

# ========== FINAL STATE DISPLAY ==========
puts "\nFinal State: #{state}"
puts "=" * 50

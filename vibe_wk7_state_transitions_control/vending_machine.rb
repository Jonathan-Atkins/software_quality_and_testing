#!/usr/bin/env ruby

# ============================================================================
# VENDING MACHINE - Week 7 Software Testing Demonstration
# ============================================================================
# This app demonstrates:
# - State Transitions: tracking machine state (Idle -> Money Inserted -> etc.)
# - Control Flow Testing: if/elsif/case logic for different scenarios
# - Data Flow Testing: tracking money, inventory, and state changes
# ============================================================================

class VendingMachine
  # ========== STATE DEFINITIONS ==========
  # States represent different phases of a transaction
  STATES = {
    idle: "Idle",
    money_inserted: "Money Inserted",
    item_selected: "Item Selected",
    dispensing: "Dispensing",
    change_returned: "Change Returned",
    cancelled: "Cancelled",
    error: "Error"
  }.freeze

  # ========== INITIALIZATION ==========
  def initialize
    # Current state of the machine
    @state = :idle

    # Money inserted by the user (in dollars)
    @balance = 0.0

    # Currently selected item
    @selected_item = nil

    # Inventory with item names and prices
    @items = {
      "1" => {name: "Soda", price: 2.50, stock: 10},
      "2" => {name: "Chips", price: 1.50, stock: 5},
      "3" => {name: "Candy", price: 1.00, stock: 8},
      "4" => {name: "Water", price: 1.25, stock: 15},
      "5" => {name: "Granola Bar", price: 2.00, stock: 3}
    }
  end

  # ========== MAIN MENU ==========
  def run
    puts "\n" + "=" * 60
    puts "          WELCOME TO THE VENDING MACHINE"
    puts "=" * 60

    loop do
      display_status
      display_menu
      user_input = gets.strip.downcase

      # CONTROL FLOW: Handle each user input with case statement
      case user_input
      when "1"
        insert_money
      when "2"
        select_item
      when "3"
        cancel_transaction
      when "q"
        exit_machine
        break
      else
        puts "❌ Invalid option. Please try again."
      end
    end
  end

  # ========== DISPLAY METHODS ==========
  def display_status
    puts "\n" + "-" * 60
    puts "Current State: #{STATES[@state]}"
    puts "Current Balance: $#{@balance.round(2)}"

    if @selected_item
      puts "Selected Item: #{@selected_item[:name]} (Price: $#{@selected_item[:price]})"
    end
    puts "-" * 60
  end

  def display_menu
    puts "\nWhat would you like to do?"
    puts "  1 - Insert Money"
    puts "  2 - Select Item"
    puts "  3 - Cancel Transaction"
    puts "  Q - Quit"
    print "Choose an option: "
  end

  def display_inventory
    puts "\n" + "=" * 60
    puts "           AVAILABLE ITEMS"
    puts "=" * 60

    @items.each do |code, item|
      # DATA FLOW: Display item information
      stock_status = (item[:stock] > 0) ? "✓ Available" : "❌ Sold Out"
      name_padded = item[:name].ljust(20, ".")
      puts "  #{code} - #{name_padded} $#{item[:price].round(2)}  #{stock_status}"
    end
    puts "=" * 60
  end

  # ========== TRANSACTION ACTIONS ==========
  def insert_money
    # STATE TRANSITION: Idle -> Money Inserted
    puts "\n💰 Insert Money"
    puts "Enter amount to insert ($): "
    amount_input = gets.strip

    # CONTROL FLOW & DATA FLOW: Validate input
    if amount_input.empty?
      puts "❌ Please enter a valid amount."
      return
    end

    amount = validate_money_input(amount_input)

    # CONTROL FLOW: Check if amount is valid
    if amount.nil? || amount <= 0
      @state = :error
      puts "❌ Invalid amount. Please insert a positive number."
      @state = :idle
      return
    end

    # DATA FLOW: Update balance
    @balance += amount

    # STATE TRANSITION: Move to money_inserted state
    @state = :money_inserted
    puts "✓ Inserted: $#{amount.round(2)}"
    puts "✓ New Balance: $#{@balance.round(2)}"
  end

  def select_item
    # CONTROL FLOW: Check if we're in appropriate state
    if @state == :idle
      puts "❌ Please insert money first!"
      return
    end

    # STATE TRANSITION: Money Inserted -> Item Selected
    display_inventory

    puts "\nEnter item number (1-5) or press ENTER to cancel: "
    item_code = gets.strip

    if item_code.empty?
      puts "❌ Selection cancelled."
      return
    end

    # CONTROL FLOW: Validate item code
    if !@items.key?(item_code)
      @state = :error
      puts "❌ Invalid item code."
      @state = :money_inserted
      return
    end

    # DATA FLOW: Get selected item
    item = @items[item_code]

    # CONTROL FLOW: Check if item is in stock
    if item[:stock] <= 0
      @state = :error
      puts "❌ Item is sold out!"
      @state = :money_inserted
      return
    end

    # CONTROL FLOW: Check if balance is sufficient
    if @balance < item[:price]
      @state = :error
      shortage = (item[:price] - @balance).round(2)
      puts "❌ Insufficient funds!"
      puts "   Need $#{shortage} more."
      @state = :money_inserted
      return
    end

    # CONTROL FLOW: Transaction is valid, proceed to dispensing
    @selected_item = item
    @state = :dispensing
    puts "✓ #{item[:name]} selected."
    dispense_item(item_code)
  end

  def dispense_item(item_code)
    # STATE: Already in dispensing state
    puts "\n🔄 Dispensing #{@selected_item[:name]}..."

    # Simulate dispensing delay
    3.times do
      print "."
      sleep(0.3)
    end
    puts " ✓"

    # DATA FLOW: Update inventory and balance
    @items[item_code][:stock] -= 1
    change = @balance - @selected_item[:price]

    # STATE TRANSITION: Dispensing -> Change Returned
    @state = :change_returned
    puts "✓ #{@selected_item[:name]} dispensed!"

    # CONTROL FLOW: Check if change needs to be returned
    if change > 0
      puts "\n💵 Returning change: $#{change.round(2)}"
      sleep(0.5)
      puts "✓ Change dispensed."
    else
      puts "✓ Exact change - no change to return."
    end

    # DATA FLOW: Reset for next transaction
    @balance = 0.0
    @selected_item = nil

    # STATE TRANSITION: Change Returned -> Idle
    @state = :idle
    puts "\n✓ Transaction complete!"
  end

  def cancel_transaction
    # CONTROL FLOW: Check if there's anything to cancel
    if @state == :idle && @balance == 0.0
      puts "❌ No transaction in progress."
      return
    end

    # STATE TRANSITION: Any state -> Cancelled
    previous_state = @state
    @state = :cancelled

    if @balance > 0
      puts "\n🔙 Cancelling transaction..."
      puts "💵 Returning balance: $#{@balance.round(2)}"
      sleep(0.5)
    end

    # DATA FLOW: Reset machine state
    @balance = 0.0
    @selected_item = nil

    # STATE TRANSITION: Cancelled -> Idle
    @state = :idle
    puts "✓ Transaction cancelled. Machine ready."
  end

  def exit_machine
    # CONTROL FLOW: Check if money is still in machine
    if @balance > 0
      puts "\n💵 Please collect your balance: $#{@balance.round(2)}"
    end

    puts "\nThank you for using the Vending Machine! Goodbye! 👋"
  end

  # ========== VALIDATION METHODS ==========
  def validate_money_input(input)
    # DATA FLOW: Validate and convert user input
    # CONTROL FLOW: Handle different input types

    amount = Float(input)

    # CONTROL FLOW: Check amount constraints
    if amount < 0
      return nil
    end

    # Round to nearest cent
    (amount * 100).round / 100.0
  rescue ArgumentError
    nil
  end
end

# ============================================================================
# EXAMPLE SCENARIOS FOR TESTING
# ============================================================================

# SUNNY DAY SCENARIO
def sunny_day_scenario
  puts "\n\n" + "★" * 60
  puts "SUNNY DAY SCENARIO: Successful transaction with change"
  puts "★" * 60

  machine = VendingMachine.new

  # Simulate: Insert $5
  machine.instance_variable_set(:@balance, 5.0)
  machine.instance_variable_set(:@state, :money_inserted)
  puts "✓ Inserted: $5.00"
  puts "✓ State: Money Inserted"

  # Simulate: Select soda ($2.50)
  item = machine.instance_variable_get(:@items)["1"]
  machine.instance_variable_set(:@selected_item, item)
  puts "✓ Selected: #{item[:name]} (Price: $#{item[:price]})"

  # Simulate: Dispense and return change
  machine.instance_variable_set(:@state, :dispensing)
  puts "🔄 Dispensing..."

  change = 5.0 - item[:price]
  machine.instance_variable_set(:@state, :change_returned)
  puts "✓ #{item[:name]} dispensed!"
  puts "✓ Returning change: $#{change.round(2)}"

  machine.instance_variable_set(:@state, :idle)
  machine.instance_variable_set(:@balance, 0.0)
  puts "✓ Transaction complete!"
  puts "✓ State: Idle"
end

# RAINY DAY SCENARIO 1: Insufficient Funds
def rainy_day_insufficient_funds
  puts "\n\n" + "★" * 60
  puts "RAINY DAY SCENARIO 1: Insufficient funds"
  puts "★" * 60

  machine = VendingMachine.new

  # Simulate: Insert $1
  machine.instance_variable_set(:@balance, 1.0)
  machine.instance_variable_set(:@state, :money_inserted)
  puts "✓ Inserted: $1.00"
  puts "✓ State: Money Inserted"

  # Try to select: chips ($1.50)
  item = machine.instance_variable_get(:@items)["2"]
  shortage = item[:price] - 1.0

  machine.instance_variable_set(:@state, :error)
  puts "❌ Selected: #{item[:name]} (Price: $#{item[:price]})"
  puts "❌ Insufficient funds! Need $#{shortage.round(2)} more."

  machine.instance_variable_set(:@state, :money_inserted)
  puts "✓ State: Money Inserted (still available for another selection)"
end

# RAINY DAY SCENARIO 2: Sold Out
def rainy_day_sold_out
  puts "\n\n" + "★" * 60
  puts "RAINY DAY SCENARIO 2: Item sold out"
  puts "★" * 60

  machine = VendingMachine.new

  # Simulate: Insert $3
  machine.instance_variable_set(:@balance, 3.0)
  machine.instance_variable_set(:@state, :money_inserted)
  puts "✓ Inserted: $3.00"
  puts "✓ State: Money Inserted"

  # Try to select granola bar (sold out)
  item = machine.instance_variable_get(:@items)["5"]
  item[:stock] = 0  # Mark as sold out

  machine.instance_variable_set(:@state, :error)
  puts "❌ Selected: #{item[:name]} (Price: $#{item[:price]})"
  puts "❌ Item is sold out!"

  machine.instance_variable_set(:@state, :money_inserted)
  puts "✓ State: Money Inserted (still available for another selection)"
end

# RAINY DAY SCENARIO 3: Cancelled transaction
def rainy_day_cancelled
  puts "\n\n" + "★" * 60
  puts "RAINY DAY SCENARIO 3: User cancels transaction"
  puts "★" * 60

  machine = VendingMachine.new

  # Simulate: Insert $5
  machine.instance_variable_set(:@balance, 5.0)
  machine.instance_variable_set(:@state, :money_inserted)
  puts "✓ Inserted: $5.00"
  puts "✓ State: Money Inserted"

  # User changes mind and cancels
  machine.instance_variable_set(:@state, :cancelled)
  puts "🔙 Cancelling transaction..."
  puts "💵 Returning balance: $5.00"

  machine.instance_variable_set(:@state, :idle)
  machine.instance_variable_set(:@balance, 0.0)
  puts "✓ State: Idle"
  puts "✓ Transaction cancelled. Machine ready."
end

# ============================================================================
# MAIN PROGRAM
# ============================================================================

if __FILE__ == $0
  # Check for demo mode
  if ARGV.include?("--demo")
    puts "🎬 RUNNING DEMO SCENARIOS"
    puts "This demonstrates testing scenarios without interactive input.\n"

    sunny_day_scenario
    rainy_day_insufficient_funds
    rainy_day_sold_out
    rainy_day_cancelled

    puts "\n\n" + "=" * 60
    puts "Demo complete! Run without --demo for interactive mode."
    puts "=" * 60
  else
    # Run interactive mode
    machine = VendingMachine.new
    machine.run
  end
end

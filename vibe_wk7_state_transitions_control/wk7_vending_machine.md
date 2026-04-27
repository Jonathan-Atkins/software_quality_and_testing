# Vibe Coding Mini Project – Week 7  
# State Transitions / Control Flow Testing / Data Flow Testing

## Introduction

This assignment focused on three software testing techniques: **State Transition Testing**, **Control Flow Testing**, and **Data Flow Testing**.

State Transition Testing is used when software changes behavior based on its current state. This is common in systems such as vending machines, ATMs, login systems, traffic lights, and shopping carts.

Control Flow Testing focuses on the logic paths inside a program. It verifies that conditions, decisions, loops, and branches execute correctly.

Data Flow Testing focuses on how data is created, modified, used, and validated throughout a program.

To demonstrate these concepts, I used GitHub Copilot to help create a Ruby command-line application named `vending_machine.rb`.

---

# Vibe Coding Assignment

## Application Overview

The Ruby app simulates a vending machine.

Users can:

1. Insert money  
2. Select an item  
3. Receive an item if enough money is available  
4. Receive change  
5. Cancel transaction  
6. Handle invalid selections  
7. Handle insufficient funds  

---

## Why This Demonstrates State Transitions

The vending machine changes between states depending on user actions.

### States Used

| Current State | Action | Next State |
|---|---|---|
| Idle | Insert Money | Money Inserted |
| Money Inserted | Select Item | Item Selected |
| Item Selected | Enough Funds | Dispensing |
| Dispensing | Return Change | Complete |
| Money Inserted | Cancel | Cancelled |
| Item Selected | Not Enough Funds | Error |

This shows how systems move from one state to another based on inputs.

---

## Why This Demonstrates Control Flow Testing

The app uses decision logic such as:

```ruby id="lj39ss"
if money >= price
  dispense item
else
  show insufficient funds
end
```

## Different inputs trigger different execution paths.

Examples:

- Enough money path
- Insufficient funds path
- Cancel path
- Invalid item path

## Why This Demonstrates Data Flow Testing

The program manages data values such as:

- inserted money
- selected item
- item price
- returned change

Example:

`change = money - price`

The value is created, modified, and then used in output.

## Sunny Day Test Case

### Scenario

User inserts $5 and buys a soda costing $2.

Input:

```ruby
5
soda
```

## Expected Output

```
Dispensing soda
Returning change: $3
```
![alt text](image-1.png)
![alt text](image-2.png)
![alt text](image-3.png)


## Rainy Day Test Case
### Scenario

User inserts $1 and selects chips costing $3.

Input:

```ruby
1
chips
```

### Expected Output
```text
Error: Insufficient funds
```

![alt text](image-4.png)
![alt text](image-5.png)
![alt text](image-6.png)


## Code Snippet

```ruby
case item
when "soda"
  price = 2
when "chips"
  price = 3
else
  puts "Invalid selection"
end
```
This demonstrates branch logic using Ruby case statements.

### Problems Encountered
- Needed to organize multiple states clearly
- Needed to validate user input
- Needed to ensure correct change calculations
- Needed to keep the code beginner-friendly
- What I Learned About AI Tools

### GitHub Copilot was useful for:

- Generating starter code quickly
- Suggesting state logic
- Helping organize conditional branches
- Speeding up development time

### However, testing was still necessary to confirm correct behavior.

## Conclusion

This assignment helped me understand how software can behave differently depending on system state. It also reinforced how conditional logic paths must be tested and how data values move through a program.

Using AI tools accelerated development, but human review was still required. This project improved my understanding of software testing techniques and practical command-line programming.
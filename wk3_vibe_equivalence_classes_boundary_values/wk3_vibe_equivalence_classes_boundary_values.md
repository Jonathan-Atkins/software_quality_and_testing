# Vibe Coding Test Case Analysis: Equivalence Classes and Boundary Value Testing

## Introduction

In this lab, we are introduced to the concept of black-box testing, where tests are designed based only on inputs and expected outputs, regardless of how the code is implemented. Although this concept is related to TDD, black-box testing focuses on what kind of tests are written, while TDD focuses on when and how testing is implemented.

Two techniques were introduced in this lab: Equivalence Class Testing (Partitioning) and Boundary Value Analysis. These techniques classify inputs based on how they cause the program to behave. For example, values 1–10 may be invalid, 11–20 valid, and 21–30 invalid, depending on the system rules. Instead of testing every value, inputs are grouped based on expected behavior.

Equivalence class testing divides input data into groups that are expected to behave similarly, allowing a single test case to represent an entire group. Boundary value analysis focuses on testing the edges of these groups, where defects are most likely to occur due to errors in conditions.

These techniques are most effective when validating structured inputs such as numeric ranges, limits, or user input fields. They improve efficiency by reducing redundant tests while still targeting high-risk areas. However, they are limited in that they do not fully capture complex workflows or internal system behavior and should be combined with other testing methods in larger systems.

---

## Sample App Overview

This assignment uses a simple Ruby command-line application that validates whether a user’s age falls within an acceptable range.

Rules:
- Valid age range: 18 to 65 (inclusive)
- Invalid if less than 18
- Invalid if greater than 65
- Invalid if input is not numeric

This application is intentionally simple so the focus remains on demonstrating testing methodology rather than application complexity.

---

## Test Case Methodology

### Equivalence Classes

The input domain is divided into the following equivalence classes:

- Valid inputs: ages between 18 and 65
- Invalid inputs (below range): ages less than 18
- Invalid inputs (above range): ages greater than 65
- Invalid inputs (non-numeric): values that cannot be converted into integers

Each class represents a set of inputs that should produce the same result. Instead of testing every possible value, one representative value is selected from each class.

### Boundary Values

Boundary value analysis focuses on the edges of the valid range:

- 17 → just below valid minimum
- 18 → minimum valid value
- 65 → maximum valid value
- 66 → just above valid maximum

These values are important because errors frequently occur at or near boundaries.

---

## Test Case Design Rationale

The test cases were intentionally created with equivalence class testing and boundary value analysis in mind.

A single representative value was chosen for each equivalence class:
- 25 represents the valid class (18–65)
- 17 represents values below the valid range
- 66 represents values above the valid range
- "abc" represents non-numeric input

Boundary values were selected because they are the most likely points of failure:
- 18 and 65 represent valid edges of the range
- 17 and 66 represent invalid values immediately outside the range

This approach ensures efficient test coverage while minimizing redundant test cases.

---

## Ruby Application

### Main Application Code

```ruby
def validate_age(input)
  begin
    age = Integer(input)
  rescue ArgumentError, TypeError
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
```

## Conclusion

The main objective of this lesson was to understand the concepts of equivalence class and boundary testing. Before this assignment, I assumed these ideas fell under OOP principles, but they are distinctly different. Equivalence class testing focuses on grouping inputs based on how the program behaves, allowing a single test to represent an entire group of inputs. Boundary testing focuses on the edges where the program’s behavior changes, which is where bugs are most likely to occur due to mistakes in conditions. ChatGPT and Copilot helped build the simple application, but more importantly helped guide my understanding that these testing strategies are separate from OOP concepts and require intentional selection of high-value test cases instead of testing inputs randomly or exhaustively.
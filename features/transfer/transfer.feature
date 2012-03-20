Feature: Transfer
  In order to transfer money from one account to another
  As a Bank
  I want not to loose money

  Scenario: I transfer money between accounts having holders
    Given I create a user Thies
    Given I create a user Norman
    When I transfer 30 dollars from Thies's account to Norman's account
    Then Thies's account balance is -30 dollars
    And Norman's account balance is 30 dollars
    And the order of the postings is correct
    
  Scenario: I transfer a negative amount between accounts having holders
    Given I create a user Thies
    Given I create a user Norman
    When I transfer -30 dollars from Thies's account to Norman's account
    Then Thies's account balance is 30 dollars
    And Norman's account balance is -30 dollars
    And the order of the postings is correct

  Scenario: I transfer money between global accounts
    Given I create a global wirecard account
    Given I create a global anonymous_donation account
    When I transfer 30 dollars from global wirecard account to global anonymous_donation account
    Then the global wirecard account balance is -30 dollars
    And the global anonymous_donation account balance is 30 dollars

  Scenario: I transfer money between accounts having a domain object
    Given I create a user Thies
    Given I create a user Norman
    When I transfer 50 dollars from Thies's account to Norman's account referencing a Cheque with number 8723
    Then Thies's account balance is -50 dollars
    And Norman's account balance is 50 dollars
    And all postings reference Cheque with number 8723
    And Cheque with number 8723 references all postings

  Scenario: I transfer money between accounts setting the booking time
    Given I create a user Thies
    Given I create a user Norman
    When I transfer 50 dollars from Thies's account to Norman's account and specify 22.05.1968 07:45 as the booking time
    Then Thies's account balance is -50 dollars
    And Norman's account balance is 50 dollars
    And all postings have 22.05.1968 07:45 as the booking time

  Scenario: Multiple transactions come in to a single account
    Given I create a global incoming account
    Given I create a global outgoing account
    When I make 10 concurrent transactions from global incoming account to global outgoing account
    Then the global incoming postings count is 10
    Then the global outgoing postings count is 10
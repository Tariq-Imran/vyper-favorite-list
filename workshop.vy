# pragma version 0.4.0
# @license MIT

# Define a struct for Person
struct Person:
    favorite_number: uint256
    name: String[100]

# State variables
my_name: public(String[100])
my_favorite_number: public(uint256)
favorite_number: public(uint256)

list_of_numbers: public(uint256[5])
list_of_people: public(Person[5])
index: public(uint256)

name_to_favorite_number: public(HashMap[String[100], uint256])

# Deploy/Initialize function
@deploy
def __init__():
    self.my_favorite_number = 7
    self.favorite_number = 10
    self.index = 0
    self.my_name = "Imran"
    

# Store a new number
@external
def store(new_number: uint256):
    self.my_favorite_number = new_number

# Increment favorite number
@external
def add(new_number: uint256):
    self.favorite_number = new_number + 1

# Retrieve favorite number
@external
@view
def retrieve() -> uint256:
    return self.my_favorite_number

# Add a new person to the contract's storage
@external
def add_person(name: String[100], favorite_number: uint256):
    # Ensure we don't exceed the list capacity
    if self.index >= 5:
        raise "Maximum number of people reached"
    
    # Add favorite number to the number list
    self.list_of_numbers[self.index] = favorite_number
    
    # Create a new Person struct
    new_person: Person = Person({
        favorite_number: favorite_number,
        name: name
    })
    
    # Add the person to the people's list
    self.list_of_people[self.index] = new_person
    
    # Add the person to the hashmap
    self.name_to_favorite_number[name] = favorite_number
    
    # Increment the index
    self.index += 1

# Retrieve a person by name from the hashmap
@external
@view
def get_person_favorite_number(name: String[100]) -> uint256:
    return self.name_to_favorite_number[name]

# Retrieve a person from the list by index
@external
@view
def get_person_by_index(person_index: uint256) -> Person:
    assert person_index < self.index, "Person index out of bounds"
    return self.list_of_people[person_index]

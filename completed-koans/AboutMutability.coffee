should = require('chai').should() # import Chai.js matchers
FILL_ME_IN = 'Fill this value in' # Don't touch this one!

describe 'About Mutability', ->
  it 'should expect object properties to be public and mutable', ->
    aPerson = 
      firstname: 'John'
      lastname: 'Smith'

    aPerson.firstname = 'Alan'
    aPerson.firstname.should.equal 'Alan'


 it 'should understand that constructed properties are public and mutable', ->
    Person = (firstname, lastname) ->
      @firstname = firstname
      @lastname = lastname

    aPerson = new Person 'John', 'Smith'
    aPerson.firstname = 'Alan'
    aPerson.firstname.should.equal 'Alan'


 it 'should expect prototype properties to be public and mutable', ->
    Person = (firstname, lastname) ->
      # Note, the initial capital in Person hints to us that
      # this is a constructor function
      @firstname = firstname
      @lastname = lastname
    Person::getFullName = -> @firstname + ' ' + @lastname
    # We can use :: as a shorthand to access an object's prototype

    aPerson = new Person 'John', 'Smith'
    aPerson.getFullName().should.equal  'John Smith'

    aPerson.getFullName = -> @lastname + ', ' + @firstname
    aPerson.getFullName().should.equal 'Smith, John'


  it 'should know that variables inside constructor and constructor args are private', ->
    Person = (firstname, lastname) ->
      fullName = firstname + ' ' + lastname
      @getFirstName = -> firstname
      @getLastName = -> lastname
      @getFullName = -> fullName
      @ # Why do we need this?

    aPerson = new Person 'John', 'Smith'
    aPerson.firstname = 'Penny'
    aPerson.lastname = 'Andrews'
    aPerson.fullName = 'Penny Andrews'
    aPerson.getFirstName().should.equal 'John'
    aPerson.getLastName().should.equal 'Smith'
    aPerson.getFullName().should.equal 'John Smith'

    aPerson.getFullName = -> aPerson.lastname + ', ' + aPerson.firstname
    aPerson.getFullName().should.equal 'Andrews, Penny' # Why?

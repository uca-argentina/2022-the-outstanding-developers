Class {
	#name : #SpaceshipTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
SpaceshipTest >> should: block raise: expectedErrorClass withMessage: expectedErrorMessage [

	self
		should: block
		raise: expectedErrorClass
		whoseDescriptionIncludes: expectedErrorMessage
		description: 'Test did not fail as expected'
]

{ #category : #tests }
SpaceshipTest >> testSpaceshipCannotBeCreatedWithEmptyPlayer [

	self
		should: [ Spaceship assignedTo: '' ]
		raise: Error
		withMessage: 'Spaceship has to be assigned to a valid player'
]

{ #category : #tests }
SpaceshipTest >> testSpaceshipCreatedWithPlayerNameIsValid [

	| spaceship playerName |
	playerName := 'SomePlayer'.
	spaceship := Spaceship assignedTo: playerName.
	self assert: spaceship player identicalTo: playerName
]

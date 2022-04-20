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
SpaceshipTest >> testHashOfSpaceshipOfPlayerOneIsDifferentFromHashOfSpaceshipOfPlayerTwo [
	| spaceshipOne spaceshipTwo |
	spaceshipOne := Spaceship assignedTo: 'playerOne'.
	spaceshipTwo := Spaceship assignedTo: 'playerTwo'.
	self assert: spaceshipOne hash ~= spaceshipTwo hash
]

{ #category : #tests }
SpaceshipTest >> testHashOfSpaceshipOfPlayerOneIsEqualToHashOfSpaceshipOfPlayerOne [
	| spaceshipOne spaceshipTwo |
	spaceshipOne := Spaceship assignedTo: 'playerOne'.
	spaceshipTwo := Spaceship assignedTo: 'playerOne'.
	self assert: spaceshipOne hash = spaceshipTwo hash
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

{ #category : #tests }
SpaceshipTest >> testSpaceshipOfPlayerOneIsDifferentFromOne [
	| spaceshipOne |
	spaceshipOne := Spaceship assignedTo: 'playerOne'.
	self assert: spaceshipOne ~= 1
]

{ #category : #tests }
SpaceshipTest >> testSpaceshipOfPlayerOneIsDifferentFromSpaceshipOfPlayerTwo [
	| spaceshipOne spaceshipTwo |
	spaceshipOne := Spaceship assignedTo: 'playerOne'.
	spaceshipTwo := Spaceship assignedTo: 'playerTwo'.
	self assert: spaceshipOne ~= spaceshipTwo
]

{ #category : #tests }
SpaceshipTest >> testSpaceshipOfPlayerOneIsEqualToSpaceshipOfPlayerOne [
	| spaceshipOne spaceshipTwo |
	spaceshipOne := Spaceship assignedTo: 'playerOne'.
	spaceshipTwo := Spaceship assignedTo: 'playerOne'.
	self assert: spaceshipOne equals: spaceshipTwo
]

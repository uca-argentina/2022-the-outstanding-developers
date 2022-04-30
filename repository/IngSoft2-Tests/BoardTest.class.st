Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
BoardTest >> should: block raise: expectedErrorClass withMessage: expectedErrorMessaje [

	self
		should: block
		raise: expectedErrorClass
		whoseDescriptionIncludes: expectedErrorMessaje
		description: 'Test did not fail as expected'
]

{ #category : #tests }
BoardTest >> testASpaceshipsPositionVariesInFiveWithAFiniteBoardAfterOneRollOfALoadedDieWithFive [

	| n spaceshipName spaceship board loadedDie resultOfTheRoll |
	n := 10.
	spaceshipName := 'aPlayer'.
	spaceship := Spaceship called: spaceshipName.
	board := Board of: n playedBy: spaceship.
	loadedDie := LoadedDie with: 5.
	resultOfTheRoll := loadedDie roll.
	board moveSpaceshipOf: spaceshipName by: resultOfTheRoll.
	self assert: (board positionOf: spaceshipName) equals: resultOfTheRoll
]

{ #category : #tests }
BoardTest >> testBoardCannotBeCreatedWithANumberOfBoxesMinorThanOne [

	| spaceship |
	spaceship := Spaceship called: 'player'.
	self
		should: [ Board of: -5 playedBy: spaceship ]
		raise: Error
		withMessage: 'Number of boxes should be greater than zero'
]

{ #category : #tests }
BoardTest >> testBoardCannotBeCreatedWithMoreThanOneSpaceshipAssignedToTheSamePlayer [

	| aSpaceship anotherSpaceship otherSpaceship |
	aSpaceship := Spaceship called: 'player1'.
	anotherSpaceship := Spaceship called: 'player1'.
	otherSpaceship := Spaceship called: 'player3'.
	self
		should: [ 
			Board of: 15 playedByMany: { 
					aSpaceship.
					anotherSpaceship.
					otherSpaceship } ]
		raise: Error
		withMessage: 'Spaceships must be assigned to different players'
]

{ #category : #tests }
BoardTest >> testBoardCannotBeCreatedWithoutSpaceships [

	self
		should: [ Board of: 1 playedByMany: {  } ]
		raise: Error
		withMessage: 'Must use at least one spaceship'
]

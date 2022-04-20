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
BoardTest >> testASpaceshipsPositionVariesInFiveWithBoardOfTenBoxesAfterOneThrowOfALoadedDieWithFive [

	| n player spaceship board loadedDie resultOfTheRoll |
	n := 10.
	player := 'aPlayer'.
	spaceship := Spaceship assignedTo: player.
	board := Board withBoxes: n andSpaceship: spaceship.
	loadedDie := LoadedDie with: 5.
	resultOfTheRoll := loadedDie roll.
	board moveSpaceshipOf: player boxes: resultOfTheRoll.
	self assert: (board positionOf: player) equals: resultOfTheRoll.
]

{ #category : #tests }
BoardTest >> testBoardCannotBeCreatedWithANumberOfBoxesMinorThanOne [

	| spaceship |
	spaceship := Spaceship assignedTo: 'player'.
	self
		should: [ Board withBoxes: -5 andSpaceship: spaceship ]
		raise: Error
		withMessage: 'Number of boxes should be greater than zero'
]

{ #category : #tests }
BoardTest >> testBoardCannotBeCreatedWithMoreThanOneSpaceshipAssignedToTheSamePlayer [

	| aSpaceship anotherSpaceship otherSpaceship |
	aSpaceship := Spaceship assignedTo: 'player1'.
	anotherSpaceship := Spaceship assignedTo: 'player1'.
	otherSpaceship := Spaceship assignedTo: 'player3'.
	self
		should: [ Board withBoxes: 15 andSpaceships: {aSpaceship. anotherSpaceship. otherSpaceship}. ]
		raise: Error
		withMessage: 'Spaceships must be assigned to different players'
]

{ #category : #tests }
BoardTest >> testLastPositionOfABoardWithNBoxesIsN [
	| board n spaceship |
	n := 10.
	spaceship := Spaceship assignedTo: 'player'.
	board := Board withBoxes: n andSpaceship: spaceship.
	self assert: board lastPosition equals: n
]

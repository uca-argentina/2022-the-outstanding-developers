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

	self
		should: [ Board with: -5 ]
		raise: Error
		withMessage: 'Number of boxes should be greater than zero'
]

{ #category : #tests }
BoardTest >> testLastPositionOfABoardWithNBoxesIsN [
	| board n |
	n := 10.
	board := Board with: n.
	self assert: board lastPosition equals: n
]

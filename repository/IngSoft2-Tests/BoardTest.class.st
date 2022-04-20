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
BoardTest >> testASpaceshipMovesNBoxesInTheBoardInTheFirstThrow [

	| board n loadedDie spaceship boxesToMove resultOfTheRoll|
	n := 10.
	board := Board with: n.
	loadedDie := LoadedDie with: 5.
	spaceship := Spaceship assignedTo: 'aPlayer' with: loadedDie.
	boxesToMove := spaceship play.
	resultOfTheRoll := loadedDie roll.
	self assert: (board moveForward: resultOfTheRoll the: spaceship) equals: boxesToMove.
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

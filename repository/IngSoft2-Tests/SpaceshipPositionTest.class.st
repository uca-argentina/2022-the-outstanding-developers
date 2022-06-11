Class {
	#name : #SpaceshipPositionTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
SpaceshipPositionTest >> should: block raise: expectedErrorClass withMessage: expectedErrorMessage [

	self
		should: block
		raise: expectedErrorClass
		whoseDescriptionIncludes: expectedErrorMessage
		description: 'Test did not fail as expected'
]

{ #category : #tests }
SpaceshipPositionTest >> testInitialBoardPositionIsFiveIfSetToFive [

	| boardPosition spaceship |
	spaceship := Spaceship called: 'aPlayer'.
	boardPosition := BoardPosition at: 5 in: 1.
	boardPosition := SpacechipPosition following: spaceship at: boardPosition .
	self assert: boardPosition position equals: 5
]

{ #category : #tests }
SpaceshipPositionTest >> testInitialBoardPositionIsZero [

	| boardPosition spaceship |
	spaceship := Spaceship called: 'aPlayer'.
	boardPosition := SpacechipPosition following: spaceship.
	self assert: boardPosition position equals: 0
]

{ #category : #tests }
SpaceshipPositionTest >> testInitialBoardPositionLapIsOne [

	| boardPosition spaceship |
	spaceship := Spaceship called: 'aPlayer'.
	boardPosition := SpacechipPosition following: spaceship.
	self assert: boardPosition lap equals: 1
]

{ #category : #tests }
SpaceshipPositionTest >> testSpaceshipPositionIsOneIfSetNegative [

	| boardPosition spaceship |
	spaceship := Spaceship called: 'aPlayer'.
	boardPosition := BoardPosition at: -1 in: 1.
	boardPosition := SpacechipPosition following: spaceship at: boardPosition .
	self assert: boardPosition position equals: 1
]

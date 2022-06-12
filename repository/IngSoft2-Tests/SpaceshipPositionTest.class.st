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

	| boardPosition delorean |
	delorean := Spaceship called: 'Delorean'.
	boardPosition := BoardPosition at: 5 in: 1.
	boardPosition := SpaceshipPosition
		                 following: delorean
		                 at: boardPosition.
	self assert: boardPosition position equals: 5
]

{ #category : #tests }
SpaceshipPositionTest >> testInitialBoardPositionIsZero [

	| boardPosition zathura |
	zathura := Spaceship called: 'Zathura'.
	boardPosition := SpaceshipPosition following: zathura.
	self assert: boardPosition position equals: 0
]

{ #category : #tests }
SpaceshipPositionTest >> testInitialBoardPositionLapIsOne [

	| boardPosition zathura |
	zathura := Spaceship called: 'aPlayer'.
	boardPosition := SpaceshipPosition following: zathura.
	self assert: boardPosition lap equals: 1
]

{ #category : #tests }
SpaceshipPositionTest >> testSpaceshipPositionIsOneIfSetNegative [

	| boardPosition zathura |
	zathura := Spaceship called: 'aPlayer'.
	boardPosition := BoardPosition at: -1 in: 1.
	boardPosition := SpaceshipPosition following: zathura at: boardPosition .
	self assert: boardPosition position equals: 1
]

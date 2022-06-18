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

	| boardPosition |
	boardPosition := BoardPosition at: 5 in: 1.
	boardPosition := SpaceshipPosition
		                 following: 'Delorean'
		                 at: boardPosition.
	self assert: boardPosition position equals: 5
]

{ #category : #tests }
SpaceshipPositionTest >> testInitialBoardPositionIsZero [

	| boardPosition |
	boardPosition := SpaceshipPosition following: 'Zathura'.
	self assert: boardPosition position equals: 0
]

{ #category : #tests }
SpaceshipPositionTest >> testInitialBoardPositionLapIsOne [

	| boardPosition |
	boardPosition := SpaceshipPosition following: 'Zathura'.
	self assert: boardPosition lap equals: 1
]

{ #category : #tests }
SpaceshipPositionTest >> testSpaceshipPositionIsOneIfSetNegative [

	| boardPosition |
	boardPosition := BoardPosition at: -1 in: 1.
	boardPosition := SpaceshipPosition
		                 following: 'Zathura'
		                 at: boardPosition.
	self assert: boardPosition position equals: 1
]

Class {
	#name : #BoardPositionTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoardPositionTest >> should: block raise: expectedErrorClass withMessage: expectedErrorMessage [

	self
		should: block
		raise: expectedErrorClass
		whoseDescriptionIncludes: expectedErrorMessage
		description: 'Test did not fail as expected'
]

{ #category : #tests }
BoardPositionTest >> testInitialBoardPositionIsFiveIfSetToFive [

	| boardPosition spaceship |
	spaceship := Spaceship called: 'aPlayer'.
	boardPosition := BoardPosition following: spaceship at: 5.
	self assert: boardPosition position equals: 5
]

{ #category : #tests }
BoardPositionTest >> testInitialBoardPositionIsZero [

	| boardPosition spaceship |
	spaceship := Spaceship called: 'aPlayer'.
	boardPosition := BoardPosition following: spaceship.
	self assert: boardPosition position equals: 0
]
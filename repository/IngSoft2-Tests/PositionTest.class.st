Class {
	#name : #PositionTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PositionTest >> should: block raise: expectedErrorClass withMessage: expectedErrorMessage [

	self
		should: block
		raise: expectedErrorClass
		whoseDescriptionIncludes: expectedErrorMessage
		description: 'Test did not fail as expected'
]

{ #category : #tests }
PositionTest >> testInitialPositionIsZero [
	| boardPosition spaceship |
	spaceship := Spaceship assignedTo: 'aPlayer'.
	boardPosition := BoardPosition with: spaceship.
	self assert: boardPosition position equals: 0.
]

{ #category : #tests }
PositionTest >> testPositionCantBeModifiedIfValueIsNegative [
	
	| boardPosition spaceship |
	spaceship := Spaceship assignedTo: 'aPlayer'.
	boardPosition := BoardPosition with: spaceship.
	self
		should: [ boardPosition move: -5 ]
		raise: Error
		withMessage: 'Spaceship cant move backwards in the board'
]

{ #category : #tests }
PositionTest >> testPositionIsFiveAfterInitialMoveOfFiveIsValid [
	| boardPosition spaceship |
	spaceship := Spaceship assignedTo: 'aPlayer'.
	boardPosition := BoardPosition with: spaceship.
	boardPosition move: 5.
	self assert: boardPosition position equals: 5.
]

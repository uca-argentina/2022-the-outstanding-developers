Class {
	#name : #PositionTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PositionTest >> testInitialPositionIsZero [
	| boardPosition spaceship |
	spaceship := Spaceship assignedTo: 'aPlayer'.
	boardPosition := BoardPosition with: spaceship.
	self assert: boardPosition position equals: 0.
]

{ #category : #tests }
PositionTest >> testPositionCantBeModifiedIfValueIsNegative [
	
]

{ #category : #tests }
PositionTest >> testPositionIsFiveAfterInitialMoveOfFiveIsValid [
	| boardPosition spaceship |
	spaceship := Spaceship assignedTo: 'aPlayer'.
	boardPosition := BoardPosition with: spaceship.
	boardPosition move: 5.
	self assert: boardPosition position equals: 5.
]

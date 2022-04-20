Class {
	#name : #TurnHandlerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
TurnHandlerTest >> testATurnHandlerInitializedWithThreeFourthTurnIsOne [

	| turnHandler |
	turnHandler := TurnHandler with: 3.
	turnHandler spaceshipToMove.
	turnHandler spaceshipToMove.
	turnHandler spaceshipToMove.
	self assert: turnHandler spaceshipToMove equals: 1.
]

{ #category : #tests }
TurnHandlerTest >> testATurnHandlerInitializedWithThreeThirdTurnIsThree [

	| turnHandler |
	turnHandler := TurnHandler with: 3.
	turnHandler spaceshipToMove.
	turnHandler spaceshipToMove.
	self assert: turnHandler spaceshipToMove equals: 3.
]

{ #category : #tests }
TurnHandlerTest >> testFirstTurnIsOne [

	| turnHandler |
	turnHandler := TurnHandler with: 3.
	self assert: turnHandler spaceshipToMove equals: 1.
]

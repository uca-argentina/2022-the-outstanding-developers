Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'boxes',
		'spaceshipsInTheBoard',
		'turnHandler',
		'positions'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Board class >> assertValid: boxes [
	boxes > 0 ifFalse: [ Error signal: 'Number of boxes should be greater than zero' ]
]

{ #category : #'instance creation' }
Board class >> with: aNumberOfBoxes [ 
	self assertValid: aNumberOfBoxes.
	^self new initializeWith: aNumberOfBoxes
]

{ #category : #'instance creation' }
Board class >> withBoxes: aNumberOfBoxes andSpaceship: aSpaceship [ 
	self assertValid: aNumberOfBoxes.
	^self new initializeWithBoxes: aNumberOfBoxes initializeWithSpaceship: aSpaceship.
]

{ #category : #'instance creation' }
Board class >> withBoxes: aNumberOfBoxes andSpaceships: someSpaceships [ 
	self assertValid: aNumberOfBoxes.
	^self new initializeWithBoxes: aNumberOfBoxes initializeWithSpaceships: someSpaceships.
]

{ #category : #initialization }
Board >> initializeWith: aNumberOfboxes [ 
	boxes := aNumberOfboxes 
]

{ #category : #initialization }
Board >> initializeWithBoxes: aNumberOfBoxes initializeWithSpaceship: aSpaceship [ 
	self initializeWithBoxes: aNumberOfBoxes initializeWithSpaceships: { aSpaceship }.
]

{ #category : #initialization }
Board >> initializeWithBoxes: aNumberOfBoxes initializeWithSpaceships: someSpaceships [ 
	boxes := aNumberOfBoxes.
	positions := someSpaceships collect: [ :spaceship | BoardPosition with: spaceship player andBoardLimit: aNumberOfBoxes].
	turnHandler := TurnHandler with: (someSpaceships size).
]

{ #category : #properties }
Board >> isThereAWinner [
	^positions anySatisfy: [:player | player position > boxes ]
]

{ #category : #properties }
Board >> lastPosition [
	^boxes 
]

{ #category : #movement }
Board >> moveSpaceship: spacesToMove [ 
	| currentPlayer |
	currentPlayer := turnHandler spaceshipToMove.
	(positions at: currentPlayer) move: spacesToMove.
]

{ #category : #playing }
Board >> moveSpaceshipOf: aPlayer boxes: aNumberOfBoxes [
	| positionToChange |
	positionToChange := (positions select: [ :position | position player = aPlayer ]) at: 1.
	positionToChange move: aNumberOfBoxes.
]

{ #category : #accessing }
Board >> positionOf: aPlayer [ 
	| positionOfPlayer |
	positionOfPlayer := (positions select: [ :position | position player = aPlayer ]) at: 1.
	^positionOfPlayer position
]

{ #category : #properties }
Board >> whoIsTheWinner [
	| winnerSpaceship |
	winnerSpaceship := (positions select: [:spaceship | spaceship position > boxes]) at: 1.
	^winnerSpaceship player.
]

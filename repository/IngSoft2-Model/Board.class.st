Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'boxes',
		'turnHandler',
		'positions'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Board class >> assertValidNumberOfBoxes: boxes [

	boxes > 0 ifFalse: [ 
		Error signal: 'Number of boxes should be greater than zero' ]
]

{ #category : #'instance creation' }
Board class >> assertValidNumberOfSpaceshipsIsGreaterThanZero: spaceships [

	spaceships isEmpty ifTrue: [ 
		Error signal: 'Must use at least one spaceship' ]
]

{ #category : #'instance creation' }
Board class >> assertValidSpaceships: spaceships [

	self assertValidNumberOfSpaceshipsIsGreaterThanZero: spaceships.
	self assertValidSpaceshipsAsigneesAreNotRepeated: spaceships
]

{ #category : #'instance creation' }
Board class >> assertValidSpaceshipsAsigneesAreNotRepeated: spaceships [

	| uniqueSpaceships |
	uniqueSpaceships := spaceships asOrderedCollection
		                       removeDuplicates asArray.

	(spaceships size = uniqueSpaceships size) ifFalse: [ 
		Error signal: 'Spaceships must be assigned to different players' ]
]

{ #category : #'instance creation' }
Board class >> withBoxes: aNumberOfBoxes andSpaceship: aSpaceship [ 
	^self withBoxes: aNumberOfBoxes andSpaceships: { aSpaceship }.
]

{ #category : #'instance creation' }
Board class >> withBoxes: aNumberOfBoxes andSpaceships: someSpaceships [ 
	self assertValidNumberOfBoxes: aNumberOfBoxes.
	self assertValidSpaceships: someSpaceships.
	^self new initializeWithBoxes: aNumberOfBoxes andSpaceships: someSpaceships.
]

{ #category : #assertions }
Board >> assertLimitOfTheBoard: currentPosition with: aNumberOfBoxesToMove [

	| positionToMove winningPosition |
	positionToMove := currentPosition + aNumberOfBoxesToMove.
	winningPosition := boxes + 1.

	positionToMove <= winningPosition
		ifFalse: [ ^ winningPosition - currentPosition ]
		ifTrue: [ ^ aNumberOfBoxesToMove ]
]

{ #category : #initialization }
Board >> initializeWithBoxes: aNumberOfBoxes andSpaceships: someSpaceships [

	boxes := aNumberOfBoxes.
	positions := someSpaceships collect: [ :spaceship | 
		             BoardPosition with: spaceship player ].
	turnHandler := TurnHandler with: someSpaceships size
]

{ #category : #properties }
Board >> isThereAWinner [

	^ positions anySatisfy: [ :boardPosition | 
		  boardPosition position > boxes ]
]

{ #category : #private }
Board >> lastPosition [

	^ boxes
]

{ #category : #movement }
Board >> moveSpaceship: boxesToMove [

	| currentPlayer currentTurn |
	currentTurn := turnHandler spaceshipToMove.
	currentPlayer := (positions at: currentTurn) player.
	self moveSpaceshipOf: currentPlayer boxes: boxesToMove
]

{ #category : #playing }
Board >> moveSpaceshipOf: aPlayer boxes: aNumberOfBoxes [

	| positionToChange numberOfBoxes |
	positionToChange := (positions select: [ :position | 
		                     position player = aPlayer ]) at: 1.
	numberOfBoxes := self
		                 assertLimitOfTheBoard: positionToChange position
		                 with: aNumberOfBoxes.
	positionToChange move: numberOfBoxes
]

{ #category : #accessing }
Board >> positionOf: aPlayer [

	| positionOfPlayer |
	positionOfPlayer := (positions select: [ :position | 
		                     position player = aPlayer ]) at: 1.
	^ positionOfPlayer position
]

{ #category : #properties }
Board >> whoIsTheWinner [

	| winnerSpaceship |
	winnerSpaceship := (positions select: [ :spaceship | 
		                    spaceship position > boxes ]) at: 1.
	^ winnerSpaceship player
]

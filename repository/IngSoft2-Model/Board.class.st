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
	boxes > 0 ifFalse: [ Error signal: 'Number of boxes should be greater than zero' ]
]

{ #category : #'instance creation' }
Board class >> assertValidSpaceships: spaceships [
	| spaceshipsDuplicate |
	spaceships isEmpty ifTrue: [ Error signal: 'Must use at least one spaceship' ].
	spaceshipsDuplicate := spaceships asOrderedCollection removeDuplicates asArray.
	(spaceships size ~= spaceshipsDuplicate size) ifTrue: [ Error signal: 'Spaceships must be assigned to different players' ]
]

{ #category : #'instance creation' }
Board class >> withBoxes: aNumberOfBoxes andSpaceship: aSpaceship [ 
	self assertValidNumberOfBoxes: aNumberOfBoxes.
	^self new initializeWithBoxes: aNumberOfBoxes andSpaceship: aSpaceship.
]

{ #category : #'instance creation' }
Board class >> withBoxes: aNumberOfBoxes andSpaceships: someSpaceships [ 
	self assertValidNumberOfBoxes: aNumberOfBoxes.
	self assertValidSpaceships: someSpaceships.
	^self new initializeWithBoxes: aNumberOfBoxes andSpaceships: someSpaceships.
]

{ #category : #assertions }
Board >> assertLimitOfTheBoard: aPosition with: aNumberOfBoxes [ 
	(aPosition + aNumberOfBoxes) <= (boxes + 1) ifFalse: [ ^(boxes - aPosition + 1) ] ifTrue: [ ^aNumberOfBoxes ]
]

{ #category : #initialization }
Board >> initializeWithBoxes: aNumberOfBoxes andSpaceship: aSpaceship [ 
	self initializeWithBoxes: aNumberOfBoxes andSpaceships: { aSpaceship }.
]

{ #category : #initialization }
Board >> initializeWithBoxes: aNumberOfBoxes andSpaceships: someSpaceships [ 
	boxes := aNumberOfBoxes.
	positions := someSpaceships collect: [ :spaceship | BoardPosition with: spaceship player].
	turnHandler := TurnHandler with: (someSpaceships size).
]

{ #category : #properties }
Board >> isThereAWinner [
	^positions anySatisfy: [:boardPosition | boardPosition position > boxes ]
]

{ #category : #private }
Board >> lastPosition [
	^boxes 
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
	positionToChange := (positions select: [ :position | position player = aPlayer ]) at: 1.
	numberOfBoxes := self assertLimitOfTheBoard: (positionToChange position) with: aNumberOfBoxes.
	positionToChange move: numberOfBoxes.
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

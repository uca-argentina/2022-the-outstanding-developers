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
Board class >> of: aNumberOfBoxes playedBy: aSpaceship [ 
	^self of: aNumberOfBoxes playedByMany: { aSpaceship }.
]

{ #category : #'instance creation' }
Board class >> of: aNumberOfBoxes playedByMany: spaceships [ 
	self assertValidNumberOfBoxes: aNumberOfBoxes.
	self assertValidSpaceships: spaceships.
	^self new of: aNumberOfBoxes playedBy: spaceships.
]

{ #category : #playing }
Board >> indexOfBoardPositionOf: aSpaceship [

	| currentPosition |
	currentPosition := (positions select: [ :position | 
		                    position spaceship = aSpaceship ]) at: 1.
	^ positions indexOf: currentPosition
]

{ #category : #movement }
Board >> moveSpaceship: aNumberOfBoxes [

	| currentSpaceship currentTurn |
	currentTurn := turnHandler spaceshipToMove.
	currentSpaceship := (positions at: currentTurn) spaceship.
	self moveSpaceshipOf: currentSpaceship by: aNumberOfBoxes
]

{ #category : #playing }
Board >> moveSpaceshipOf: aSpaceship by: aNumberOfBoxes [

	| numberOfBoxes newPosition index currentBoardPosition |
	index := self indexOfBoardPositionOf: aSpaceship.
	currentBoardPosition := (positions at: index) position.
	numberOfBoxes := self
		                 nextPositionStartingAt: currentBoardPosition
		                 afterMoving: aNumberOfBoxes.
	newPosition := BoardPosition
		               following: aSpaceship
		               at: currentBoardPosition + numberOfBoxes.
	positions replaceFrom: index to: index with: { newPosition }
]

{ #category : #assertions }
Board >> nextPositionStartingAt: position afterMoving: aNumberOfBoxes [

	| positionToMove winningPosition |
	positionToMove := position + aNumberOfBoxes.
	winningPosition := boxes + 1.

	positionToMove <= winningPosition
		ifFalse: [ ^ winningPosition - position ]
		ifTrue: [ ^ aNumberOfBoxes ]
]

{ #category : #initialization }
Board >> of: aNumberOfBoxes playedBy: spaceships [

	boxes := aNumberOfBoxes.
	positions := spaceships collect: [ :spaceship | 
		             BoardPosition following: spaceship player ].
	turnHandler := TurnHandler with: spaceships size
]

{ #category : #accessing }
Board >> positionOf: aSpaceship [

	| positionOfSpaceship |
	positionOfSpaceship := (positions select: [ :position | 
		                        position spaceship = aSpaceship ]) at: 1.
	^ positionOfSpaceship position
]

{ #category : #properties }
Board >> thereIsAWinner [

	^ positions anySatisfy: [ :boardPosition | 
		  boardPosition position > boxes ]
]

{ #category : #properties }
Board >> winner [

	| winnerSpaceship |
	winnerSpaceship := (positions select: [ :spaceship | 
		                    spaceship position > boxes ]) at: 1.
	^ winnerSpaceship spaceship 
]

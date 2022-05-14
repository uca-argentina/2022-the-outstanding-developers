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
Board class >> of: aNumberOfBoxes playedBy: aSpaceship andA: sequenceBox [

	^ self new of: aNumberOfBoxes playedBy: {aSpaceship} andA: sequenceBox
]

{ #category : #'instance creation' }
Board class >> of: aNumberOfBoxes playedByMany: spaceships [ 
	self assertValidNumberOfBoxes: aNumberOfBoxes.
	self assertValidSpaceships: spaceships.
	^self new of: aNumberOfBoxes playedBy: spaceships.
]

{ #category : #'instance creation' }
Board class >> of: aNumberOfBoxes playedByMany: spaceships andA: sequenceBox [
	self assertValidNumberOfBoxes: aNumberOfBoxes.
	self assertValidSpaceships: spaceships.
	^ self new of: aNumberOfBoxes playedBy: spaceships andA: sequenceBox
]

{ #category : #properties }
Board >> amountOfBoxes [

	^ boxes size
]

{ #category : #properties }
Board >> amountOfNormalBoxes [
	^boxes size *0.4.
]

{ #category : #asserting }
Board >> assertThisIsPlayersTurn: index [

	(turnHandler assertSequenceIndexIs: index) ifFalse: [ 
		Error signal: 'This is not the players turn' ]
]

{ #category : #playing }
Board >> indexOfBoardPositionOf: aSpaceship [

	| currentPosition |
	currentPosition := (positions select: [ :position | 
		                    position spaceship = aSpaceship ]) at: 1.
	^ positions indexOf: currentPosition
]

{ #category : #movement }
Board >> moveAfterEffect: anAmount [

	| spaceshipToMove currentBoardPosition spaceshipIndex numberOfBoxes newPosition |
	spaceshipToMove := (positions at: turnHandler index) spaceship.
	spaceshipIndex := self indexOfBoardPositionOf: spaceshipToMove.
	currentBoardPosition := (positions at: spaceshipIndex) position.
	numberOfBoxes := self
		                 nextPositionStartingAt: currentBoardPosition
		                 afterMoving: anAmount.
	newPosition := BoardPosition
		               following: spaceshipToMove
		               at: currentBoardPosition + numberOfBoxes.
	positions replaceFrom: spaceshipIndex  to: spaceshipIndex  with: { newPosition }
]

{ #category : #movement }
Board >> moveAllBackToBeginning [

	| spaceshipToMove spaceshipIndex newPosition |
	positions size timesRepeat: [ 
		spaceshipToMove := (positions at: turnHandler index)
			                   spaceship.
		spaceshipIndex := self indexOfBoardPositionOf: spaceshipToMove.
		newPosition := BoardPosition following: spaceshipToMove at: 1.
		positions
			replaceFrom: spaceshipIndex
			to: spaceshipIndex
			with: { newPosition } ].
]

{ #category : #movement }
Board >> moveAllExceptCurrentBy: anAmount [
	(positions size -1) timesRepeat: [ self moveAfterEffect: anAmount ]
]

{ #category : #movement }
Board >> moveCurrentBy: anAmount [
	| spaceshipToMove spaceshipIndex currentBoardPosition numberOfBoxes newPosition |
	spaceshipToMove := (positions at: turnHandler currentIndex) spaceship.
	spaceshipIndex := self indexOfBoardPositionOf: spaceshipToMove.
	currentBoardPosition := (positions at: spaceshipIndex) position.
	numberOfBoxes := self
		                 nextPositionStartingAt: currentBoardPosition
		                 afterMoving: anAmount.
	newPosition := BoardPosition
		               following: spaceshipToMove
		               at: currentBoardPosition + numberOfBoxes.
	positions replaceFrom: spaceshipIndex  to: spaceshipIndex  with: { newPosition }
]

{ #category : #movement }
Board >> moveSpaceship: aNumberOfBoxes [

	| currentSpaceship |
	currentSpaceship := (positions at: turnHandler index) spaceship.
	self moveSpaceshipOf: currentSpaceship by: aNumberOfBoxes
]

{ #category : #playing }
Board >> moveSpaceshipOf: aSpaceship by: aNumberOfBoxes [

	| numberOfBoxes newPosition index currentBoardPosition currentBox finalPosition |
	index := self indexOfBoardPositionOf: aSpaceship.
	self assertThisIsPlayersTurn: index.
	currentBoardPosition := (positions at: index) position.
	numberOfBoxes := self
		                 nextPositionStartingAt: currentBoardPosition
		                 afterMoving: aNumberOfBoxes.
	newPosition := BoardPosition
		               following: aSpaceship
		               at: currentBoardPosition + numberOfBoxes.
	currentBox := boxes at: newPosition position.
	positions replaceFrom: index to: index with: { newPosition }.
	currentBox effectOnPosition: self
]

{ #category : #assertions }
Board >> nextPositionStartingAt: position afterMoving: aNumberOfBoxes [

	| positionToMove winningPosition |
	positionToMove := position + aNumberOfBoxes.
	winningPosition := self amountOfBoxes + 1.

	positionToMove <= winningPosition
		ifFalse: [ ^ winningPosition - position ]
		ifTrue: [ ^ aNumberOfBoxes ]
]

{ #category : #initialization }
Board >> of: aNumberOfBoxes playedBy: spaceships [

	boxes := OrderedCollection new.
	aNumberOfBoxes timesRepeat: [ boxes add: (Box withEffect: NormalBox new)].
	positions := spaceships collect: [ :spaceship | 
		             BoardPosition following: spaceship name ].
	turnHandler := SequenceHandler for: spaceships size
]

{ #category : #initialization }
Board >> of: aNumberOfBoxes playedBy: spaceships andA: sequenceBox [

	| sequenceHandler |
	boxes := OrderedCollection new.
	sequenceHandler := SequenceHandler for: sequenceBox size.
	aNumberOfBoxes timesRepeat: [ boxes add: ( sequenceBox at: sequenceHandler index ) ].
	positions := spaceships collect: [ :spaceship | 
		             BoardPosition following: spaceship name ].
	turnHandler := SequenceHandler for: spaceships size
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
		  boardPosition position > self amountOfBoxes  ]
]

{ #category : #properties }
Board >> winner [

	| winnerSpaceship |
	winnerSpaceship := (positions select: [ :spaceship | 
		                    spaceship position > self amountOfBoxes  ]) at: 1.
	^ winnerSpaceship spaceship 
]

Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'boxes',
		'turnHandler',
		'positions',
		'laps',
		'boxLength'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #assertion }
Board class >> assertLength: parsecsAmount greaterThan: aNumberOfBoxes [

	parsecsAmount >= aNumberOfBoxes ifFalse: [ 
		Error signal:
			'Board length should be greater or equal to number of boxes' ]
]

{ #category : #assertion }
Board class >> assertValidNumberOfBoxes: boxes [

	boxes > 0 ifFalse: [ 
		Error signal: 'Number of boxes should be greater than zero' ]
]

{ #category : #assertion }
Board class >> assertValidNumberOfLaps: laps [

	laps > 0 ifFalse: [ 
		Error signal: 'Number of laps should be greater than zero' ]
]

{ #category : #assertion }
Board class >> assertValidNumberOfLength: parsecsLength [

	parsecsLength > 0 ifFalse: [ 
		Error signal: 'Board length should be greater than zero' ]
]

{ #category : #assertion }
Board class >> assertValidNumberOfSpaceshipsIsGreaterThanZero: spaceships [

	spaceships isEmpty ifTrue: [ 
		Error signal: 'Must use at least one spaceship' ]
]

{ #category : #assertion }
Board class >> assertValidSpaceships: spaceships [

	self assertValidNumberOfSpaceshipsIsGreaterThanZero: spaceships.
	self assertValidSpaceshipsAsigneesAreNotRepeated: spaceships
]

{ #category : #assertion }
Board class >> assertValidSpaceshipsAsigneesAreNotRepeated: spaceships [

	| uniqueSpaceships |
	uniqueSpaceships := spaceships asOrderedCollection
		                       removeDuplicates asArray.

	(spaceships size = uniqueSpaceships size) ifFalse: [ 
		Error signal: 'Spaceships must be assigned to different players' ]
]

{ #category : #'instance creation' }
Board class >> of: aNumberOfBoxes and: parsecsLength playedFor: someLaps by: aSpaceship givenBy: aDistribution [

	^ self
		  of: aNumberOfBoxes
		  and: parsecsLength
		  playedFor: someLaps
		  byMany: { aSpaceship }
		  givenBy: aDistribution
]

{ #category : #'instance creation' }
Board class >> of: aNumberOfBoxes and: parsecsLength playedFor: someLaps by: aSpaceship with: aBoxSequence [

	^ self
		  of: aNumberOfBoxes
		  and: parsecsLength
		  playedFor: someLaps
		  byMany: { aSpaceship }
		  with: aBoxSequence
]

{ #category : #'instance creation' }
Board class >> of: aNumberOfBoxes and: parsecsLength playedFor: someLaps byMany: spaceships givenBy: aDistribution [

	| randomBoxGenerator boxSequnce |
	self assertValidNumberOfBoxes: aNumberOfBoxes.
	self assertValidSpaceships: spaceships.
	self assertValidNumberOfLaps: someLaps.
	self assertValidNumberOfLength: parsecsLength.
	self assertLength: parsecsLength greaterThan: aNumberOfBoxes.
	randomBoxGenerator := RandomEventGenerator
		                      with: aNumberOfBoxes
		                      using: aDistribution.
	boxSequnce := randomBoxGenerator generate collect: [ :effect | 
		              Box with: effect ].
	^ self new
		  of: aNumberOfBoxes
		  and: parsecsLength
		  playedFor: someLaps
		  byMany: spaceships
		  with: boxSequnce
]

{ #category : #'instance creation' }
Board class >> of: aNumberOfBoxes and: parsecsLength playedFor: someLaps byMany: spaceships with: aBoxSequence [

	self assertValidNumberOfBoxes: aNumberOfBoxes.
	self assertValidSpaceships: spaceships.
	self assertValidNumberOfLaps: someLaps.
	self assertValidNumberOfLength: parsecsLength.
	self assertLength: parsecsLength greaterThan: aNumberOfBoxes.
	^ self new
		  of: aNumberOfBoxes
		  and: parsecsLength
		  playedFor: someLaps
		  byMany: spaceships
		  with: aBoxSequence
]

{ #category : #properties }
Board >> amountOfAtomicBombBoxes [
	^ self amountOfBoxes: 'atomicbomb'
]

{ #category : #properties }
Board >> amountOfBoxes [

	^ boxes size
]

{ #category : #properties }
Board >> amountOfBoxes: type [

	| normalBoxes |
	normalBoxes := 0.
	1 to: boxes size do: [ :i | 
		| box |
		box := boxes at: i.
		box effectType = type ifTrue: [ normalBoxes := normalBoxes + 1 ] ].
	^ normalBoxes
]

{ #category : #properties }
Board >> amountOfHyperJumpBoxes [
	^ self amountOfBoxes: 'hyperjump'
]

{ #category : #properties }
Board >> amountOfMoonWalkBoxes [

	^ self amountOfBoxes: 'moonwalk'
]

{ #category : #properties }
Board >> amountOfNormalBoxes [

	^ self amountOfBoxes: 'normal'
]

{ #category : #properties }
Board >> amountOfSpeedUpBoxes [

	^ self amountOfBoxes: 'speedup'
]

{ #category : #properties }
Board >> amountOfWormHoleBoxes [

	^ self amountOfBoxes: 'wormhole'
]

{ #category : #asserting }
Board >> assertThisIsPlayersTurn: index [

	(turnHandler assertSequenceIndexIs: index) ifFalse: [ 
		Error signal: 'This is not the players turn' ]
]

{ #category : #accessing }
Board >> boxLength [

	^ boxLength
]

{ #category : #playing }
Board >> indexOfBoardPositionOf: aSpaceship [

	| currentPosition |
	currentPosition := (positions select: [ :position | 
		                    position spaceship = aSpaceship ]) at: 1.
	^ positions indexOf: currentPosition
]

{ #category : #accessing }
Board >> lapOf: aSpaceship [

	| spaceshipLap |
	spaceshipLap := (positions select: [ :position | 
		                 position spaceship = aSpaceship ]) at: 1.
	^ spaceshipLap lap
]

{ #category : #playing }
Board >> move: aSpaceship in: aPosition and: aLap by: aNumberOfBoxes [

	| numberOfBoxes newPosition |

	numberOfBoxes := self
		                 nextPositionStartingAt: aPosition
		                 in: aLap
		                 afterMoving: aNumberOfBoxes.
	newPosition := numberOfBoxes = -1
		               ifFalse: [ 
			               BoardPosition
				               following: aSpaceship
				               at: aPosition + numberOfBoxes
				               in: aLap ]
		               ifTrue: [ 
		               BoardPosition
			               following: aSpaceship
			               at: 1
			               in: aLap + 1 ].
	^ newPosition
]

{ #category : #movement }
Board >> moveAfterEffect: anAmount [

	| currentSpaceship numberOfBoxes |
	currentSpaceship := positions at: turnHandler currentIndex.
	positions := positions collect: [ :position | 
		             currentSpaceship spaceship = position spaceship
			             ifFalse: [ 
				             numberOfBoxes := self
					                              nextPositionStartingAt:
					                              position position
														  in: position lap
					                              afterMoving: anAmount.
				             BoardPosition
					             following: position spaceship
					             at: position position + numberOfBoxes
					             in: position lap ]
			             ifTrue: [ position ] ]
]

{ #category : #movement }
Board >> moveAllBackToBeginning [

	| currentPosition spaceshipIndex newPosition spaceshipCurrentLap |
	positions size timesRepeat: [ 
		currentPosition := positions at: turnHandler index.
		spaceshipCurrentLap := currentPosition lap.
		spaceshipIndex := self indexOfBoardPositionOf: currentPosition spaceship.
		newPosition := BoardPosition
			               following: currentPosition spaceship
			               at: 1
			               in: spaceshipCurrentLap.
		positions
			replaceFrom: spaceshipIndex
			to: spaceshipIndex
			with: { newPosition } ]
]

{ #category : #movement }
Board >> moveAllExceptCurrentBy: anAmount [

	positions size - 1 timesRepeat: [ self moveAfterEffect: anAmount ]
]

{ #category : #movement }
Board >> moveSpaceship: aNumberOfBoxes [

	| currentSpaceship |
	currentSpaceship := (positions at: turnHandler index) spaceship.
	self moveSpaceshipOf: currentSpaceship by: aNumberOfBoxes
]

{ #category : #playing }
Board >> moveSpaceshipOf: aSpaceship by: aNumberOfBoxes [

	| newPositionWithoutEffect index currentBox movementAfterEffect currentBoardPosition currentLap newPositionAfterEffect|
	index := self indexOfBoardPositionOf: aSpaceship.
	self assertThisIsPlayersTurn: index.
	
	currentBoardPosition := (positions at: index) position.
	currentLap := (positions at: index) lap.
	
	newPositionWithoutEffect := (self move: aSpaceship in: currentBoardPosition and: currentLap by: aNumberOfBoxes).
	
	newPositionWithoutEffect position > boxes size ifTrue: [ positions replaceFrom: index to: index with: { newPositionWithoutEffect }.
		^self ].
	currentBox := boxes at: newPositionWithoutEffect position.
	movementAfterEffect := currentBox effectOnPosition: self.
	movementAfterEffect = 'Do not move' 
	ifFalse: [newPositionAfterEffect := (self move: aSpaceship in: (newPositionWithoutEffect position) and: (newPositionWithoutEffect lap) by: movementAfterEffect)]
	ifTrue: [ ^self ].
	positions replaceFrom: index to: index with: { newPositionAfterEffect }.
]

{ #category : #assertions }
Board >> nextPositionStartingAt: position in: lap afterMoving: aNumberOfBoxes [

	| positionToMove winningPosition |
	positionToMove := position + aNumberOfBoxes.
	winningPosition := self amountOfBoxes + 1.

	lap < laps
		ifTrue: [ 
			positionToMove < winningPosition
				ifFalse: [ ^ -1 ]
				ifTrue: [ ^ aNumberOfBoxes ] ]
		ifFalse: [ 
			positionToMove <= winningPosition
				ifFalse: [ ^ winningPosition - position ]
				ifTrue: [ ^ aNumberOfBoxes ] ]
]

{ #category : #initialization }
Board >> of: aNumberOfBoxes and: parsecsLength playedFor: someLaps byMany: spaceships with: aBoxSequence [

	| sequenceHandler |
	boxes := OrderedCollection new.
	sequenceHandler := SequenceHandler for: aBoxSequence size.
	aNumberOfBoxes timesRepeat: [ 
		boxes add: (aBoxSequence at: sequenceHandler index) ].
	laps := someLaps.
	positions := spaceships collect: [ :spaceship | 
		             BoardPosition following: spaceship name ].
	turnHandler := SequenceHandler for: spaceships size.
	boxLength := parsecsLength / aNumberOfBoxes
]

{ #category : #accessing }
Board >> positionOf: aSpaceship [

	| positionOfSpaceship |
	positionOfSpaceship := (positions select: [ :position | 
		                        position spaceship = aSpaceship ]) at: 1.
	^ positionOfSpaceship position
]

{ #category : #accessing }
Board >> rankingPositionOf: aSpaceshipName [

	| index notFound sortedPositionsForRanking |
	sortedPositionsForRanking := positions sort: [ :positionA :positionB | 
		                             positionA > positionB ].
	index := 1.
	notFound := true.
	[ index <= sortedPositionsForRanking size and: [ notFound ] ] 
		whileTrue: [ 
			(sortedPositionsForRanking at: index) spaceship = aSpaceshipName
				ifTrue: [ notFound := false ]
				ifFalse: [ index := index + 1 ] ].
	^ index
]

{ #category : #properties }
Board >> thereIsAWinner [

	^ positions anySatisfy: [ :boardPosition | 
		  boardPosition position > self amountOfBoxes
		  & (boardPosition lap = laps) ]
]

{ #category : #properties }
Board >> winner [

	| winnerSpaceship |
	winnerSpaceship := (positions select: [ :spaceship | 
		                    spaceship position > self amountOfBoxes ]) at: 1.
	^ winnerSpaceship spaceship
]

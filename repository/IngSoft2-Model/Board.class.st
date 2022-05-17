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
Board class >> of: aNumberOfBoxes andLength: parsecsAmount for: someLaps playedByMany: spaceships [

	self assertValidNumberOfBoxes: aNumberOfBoxes.
	self assertValidSpaceships: spaceships.
	self assertValidNumberOfLaps: someLaps.
	self assertValidNumberOfLength: parsecsAmount.
	self assertLength: parsecsAmount greaterThan: aNumberOfBoxes.
	^ self new
		  of: aNumberOfBoxes
		  andLength: parsecsAmount
		  for: someLaps
		  playedByMany: spaceships
]

{ #category : #'instance creation' }
Board class >> of: aNumberOfBoxes andLength: parsecsAmount withNumberOfLaps: someLaps playedBy: aSpaceship [  
	
	^self of: aNumberOfBoxes andLength: parsecsAmount for: someLaps playedByMany: { aSpaceship }.
]

{ #category : #'instance creation' }
Board class >> of: aNumberOfBoxes andLength: someParsecs withNumberOfLaps: someLaps playedByMany: spaceships andA: boxSequence [ 
	self assertValidNumberOfBoxes: aNumberOfBoxes.
	self assertValidSpaceships: spaceships.
	self assertValidNumberOfLaps: someLaps.
	^self new of: aNumberOfBoxes andLength: someParsecs for: someLaps playedBy: spaceships andA: boxSequence 
]

{ #category : #'instance creation' }
Board class >> of: aNumberOfBoxes for: someLaps playedBy: aSpaceship andA: sequenceBox [

	^ self new of: aNumberOfBoxes for: someLaps playedBy: {aSpaceship} andA: sequenceBox
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
	^self new of: aNumberOfBoxes playedBy: spaceships andA: sequenceBox
]

{ #category : #'instance creation' }
Board class >> of: aNumberOfBoxes withNumberOfLaps: someLaps playedBy: aSpaceship [ 
	^self of: aNumberOfBoxes withNumberOfLaps: someLaps playedByMany: { aSpaceship }.
]

{ #category : #'instance creation' }
Board class >> of: aNumberOfBoxes withNumberOfLaps: someLaps playedBy: aSpaceship andA: sequenceBox [ 
	^self of: aNumberOfBoxes withNumberOfLaps: someLaps playedByMany: { aSpaceship } andA: sequenceBox.
]

{ #category : #'instance creation' }
Board class >> of: aNumberOfBoxes withNumberOfLaps: someLaps playedByMany: spaceships [ 
	self assertValidNumberOfBoxes: aNumberOfBoxes.
	self assertValidSpaceships: spaceships.
	self assertValidNumberOfLaps: someLaps.
	^self new of: aNumberOfBoxes for: someLaps playedBy: spaceships.
]

{ #category : #'instance creation' }
Board class >> of: aNumberOfBoxes withNumberOfLaps: someLaps playedByMany: spaceships andA: sequenceBox [
	self assertValidNumberOfBoxes: aNumberOfBoxes.
	self assertValidSpaceships: spaceships.
	self assertValidNumberOfLaps: someLaps.
	^self new of: aNumberOfBoxes for: someLaps playedBy: spaceships andA: sequenceBox
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
					                              afterMoving: anAmount.
				             BoardPosition
					             following: position spaceship
					             at: position position + numberOfBoxes
					             in: position lap ]
			             ifTrue: [ position ] ]
]

{ #category : #movement }
Board >> moveAllBackToBeginning [

	| spaceshipToMove spaceshipIndex newPosition spaceshipCurrentLap |
	positions size timesRepeat: [ 
		spaceshipToMove := (positions at: turnHandler index) spaceship.
		spaceshipCurrentLap := (positions at: turnHandler index) lap.
		spaceshipIndex := self indexOfBoardPositionOf: spaceshipToMove.
		newPosition := BoardPosition following: spaceshipToMove at: 1 in: spaceshipCurrentLap.
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
Board >> moveCurrentBy: anAmount [

	| spaceshipToMove spaceshipIndex currentBoardPosition numberOfBoxes newPosition currentBoardLap |
	spaceshipToMove := (positions at: turnHandler currentIndex) spaceship.
	spaceshipIndex := self indexOfBoardPositionOf: spaceshipToMove.
	currentBoardPosition := (positions at: spaceshipIndex) position.
	currentBoardLap := (positions at: spaceshipIndex) lap.
	numberOfBoxes := self
		                 nextPositionStartingAt: currentBoardPosition
		                 afterMoving: anAmount.
	newPosition := BoardPosition
		               following: spaceshipToMove
		               at: currentBoardPosition + numberOfBoxes
		               in: currentBoardLap.
	positions
		replaceFrom: spaceshipIndex
		to: spaceshipIndex
		with: { newPosition }
]

{ #category : #movement }
Board >> moveSpaceship: aNumberOfBoxes [

	| currentSpaceship |
	currentSpaceship := (positions at: turnHandler index) spaceship.
	self moveSpaceshipOf: currentSpaceship by: aNumberOfBoxes
]

{ #category : #playing }
Board >> moveSpaceshipOf: aSpaceship by: aNumberOfBoxes [

	| numberOfBoxes newPosition index currentBoardPosition currentBox currentLap |
	index := self indexOfBoardPositionOf: aSpaceship.
	self assertThisIsPlayersTurn: index.
	currentBoardPosition := (positions at: index) position.
	currentLap := (positions at: index) lap.
	numberOfBoxes := self
		                 nextPositionStartingAt: currentBoardPosition
		                 in: currentLap
		                 afterMoving: aNumberOfBoxes.
	numberOfBoxes = 0
		ifFalse: [ 
			newPosition := BoardPosition
				               following: aSpaceship
				               at: currentBoardPosition + numberOfBoxes
				               in: currentLap ]
		ifTrue: [ 
			newPosition := BoardPosition
				               following: aSpaceship
				               at: 1
				               in: currentLap + 1 ].
	positions replaceFrom: index to: index with: { newPosition }.
	newPosition position > boxes size ifFalse: [ 
		currentBox := boxes at: newPosition position.
		currentBox effectOnPosition: self ]
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

{ #category : #assertions }
Board >> nextPositionStartingAt: position in: lap afterMoving: aNumberOfBoxes [

	| positionToMove winningPosition |
	positionToMove := position + aNumberOfBoxes.
	winningPosition := self amountOfBoxes + 1.

	lap < laps
		ifTrue: [ 
			positionToMove <= winningPosition
				ifFalse: [ ^ 0 ]
				ifTrue: [ ^ aNumberOfBoxes ] ]
		ifFalse: [ 
			positionToMove <= winningPosition
				ifFalse: [ ^ winningPosition - position ]
				ifTrue: [ ^ aNumberOfBoxes ] ]
]

{ #category : #initialization }
Board >> of: aNumberOfBoxes andLength: someParsecs for: someLaps playedBy: spaceships andA: boxSequence [

	| sequenceHandler |
	boxes := OrderedCollection new.
	sequenceHandler := SequenceHandler for: boxSequence size.
	aNumberOfBoxes timesRepeat: [ 
		boxes add: (boxSequence at: sequenceHandler index) ].
	laps := someLaps.
	positions := spaceships collect: [ :spaceship | 
		             BoardPosition following: spaceship name ].
	turnHandler := SequenceHandler for: spaceships size.
	boxLength := someParsecs / aNumberOfBoxes
]

{ #category : #initialization }
Board >> of: aNumberOfBoxes andLength: parsecsAmount for: someLaps playedByMany: spaceships [

	boxes := OrderedCollection new.
	aNumberOfBoxes timesRepeat: [ 
		boxes add: (Box withEffect: NormalBox new) ].
	laps := someLaps.
	positions := spaceships collect: [ :spaceship | 
		             BoardPosition following: spaceship name ].
	turnHandler := SequenceHandler for: spaceships size.
	boxLength := parsecsAmount / aNumberOfBoxes
]

{ #category : #initialization }
Board >> of: aNumberOfBoxes for: someLaps playedBy: spaceships [

	| randomBoxGenerator |
	randomBoxGenerator := RandomBoxGenerator with: aNumberOfBoxes.
	boxes := randomBoxGenerator generate.
	laps := someLaps.
	positions := spaceships collect: [ :spaceship | 
		             BoardPosition following: spaceship name ].
	turnHandler := SequenceHandler for: spaceships size.
]

{ #category : #initialization }
Board >> of: aNumberOfBoxes for: someLaps playedBy: spaceships andA: boxSequence [

	| sequenceHandler |
	boxes := OrderedCollection new.
	sequenceHandler := SequenceHandler for: boxSequence size.
	aNumberOfBoxes timesRepeat: [ 
		boxes add: (boxSequence at: sequenceHandler index) ].
	laps := someLaps.
	positions := spaceships collect: [ :spaceship | 
		             BoardPosition following: spaceship name ].
	turnHandler := SequenceHandler for: spaceships size
]

{ #category : #initialization }
Board >> of: aNumberOfBoxes playedBy: spaceships [

	boxes := OrderedCollection new.
	aNumberOfBoxes timesRepeat: [ 
		boxes add: (Box withEffect: NormalBox new) ].
	positions := spaceships collect: [ :spaceship | 
		             BoardPosition following: spaceship name ].
	turnHandler := SequenceHandler for: spaceships size
]

{ #category : #initialization }
Board >> of: aNumberOfBoxes playedBy: spaceships andA: boxSequence [

	| sequenceHandler |
	boxes := OrderedCollection new.
	sequenceHandler := SequenceHandler for: boxSequence size.
	aNumberOfBoxes timesRepeat: [ 
		boxes add: (boxSequence at: sequenceHandler index) ].
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

{ #category : #accessing }
Board >> rankingPositionOf: aSpaceshipName [

	| rankingValues sortedRankingValues index notFound |
	rankingValues := positions collect: [ :position | 
		                 RankingValue of: position withSize: boxes size ].
	sortedRankingValues := rankingValues sort: [ :rankingA :rankingB | 
		                       rankingA absolutePosition
		                       > rankingB absolutePosition ].
	index := 1.
	notFound := true.
	[ index <= sortedRankingValues size and: [ notFound ] ] whileTrue: [ 
		(sortedRankingValues at: index) spaceship = aSpaceshipName
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

Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'boxes',
		'turnHandler',
		'positions',
		'laps',
		'boxParsecLength'
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
Board >> amountOfBoxes: aType [

	^(boxes select:[:box | box effectType = aType]) size.
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
Board >> amountOfNoEffectBoxes [

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
Board >> boxParsecLength [

	^ boxParsecLength
]

{ #category : #accessing }
Board >> lapOf: aSpaceship [

	| spaceshipLap |
	spaceshipLap := (positions select: [ :position | 
		                 position spaceship = aSpaceship ]) at: 1.
	^ spaceshipLap lap
]

{ #category : #playing }
Board >> move: aSpaceship by: aNumberOfBoxes [

	| newPositionWithoutEffect positionAmongPositions currentBox movementAfterEffect currentBoardPosition currentLap newPositionAfterEffect|
	positionAmongPositions := self positionInPositionsOf: aSpaceship.
	self assertThisIsPlayersTurn: positionAmongPositions.
	
	currentBoardPosition := (positions at: positionAmongPositions) position.
	currentLap := (positions at: positionAmongPositions) lap.
	
	newPositionWithoutEffect := (self move: aSpaceship in: currentBoardPosition and: currentLap by: aNumberOfBoxes).
	
	newPositionWithoutEffect position > boxes size ifTrue: [ positions replaceFrom: positionAmongPositions to: positionAmongPositions with: { newPositionWithoutEffect }.
		^self ].
	currentBox := boxes at: newPositionWithoutEffect position.
	movementAfterEffect := currentBox applyEffectOn: self.
	movementAfterEffect = 'Do not move' 
	ifFalse: [newPositionAfterEffect := (self move: aSpaceship in: (newPositionWithoutEffect position) and: (newPositionWithoutEffect lap) by: movementAfterEffect)]
	ifTrue: [ ^self ].
	positions replaceFrom: positionAmongPositions to: positionAmongPositions with: { newPositionAfterEffect }.
]

{ #category : #playing }
Board >> move: aSpaceship in: aPosition and: aLap by: aNumberOfBoxes [

	| positionToMove newPosition |
	positionToMove := self
		                 nextPositionStartingAt: aPosition
		                 in: aLap
		                 afterMoving: aNumberOfBoxes.
	newPosition := positionToMove = -1
		               ifFalse: [ 
			               SpacechipPosition
				               following: aSpaceship
				               at:
				               (BoardPosition
					                at: positionToMove
					                in: aLap) ]
		               ifTrue: [ 
			               SpacechipPosition
				               following: aSpaceship
				               at: (BoardPosition at: 1 in: aLap + 1) ].
	^ newPosition
]

{ #category : #movement }
Board >> moveAllBackToBeginning [

	positions size timesRepeat: [
		| currentPosition |
		currentPosition := positions at: turnHandler index.
		self movePlayingSpaceshipAt: currentPosition by: 1 - currentPosition position ]
]

{ #category : #movement }
Board >> moveAllExceptCurrentBy: anAmount [

	positions size timesRepeat: [
		| currentPosition |
		currentPosition := positions at: turnHandler index.
		self movePlayingSpaceshipAt: currentPosition by: anAmount ]
]

{ #category : #movement }
Board >> movePlayingSpaceshipAt: aPosition by: anAmount [

	| newPosition spaceshipIndex |
	^ aPosition position ~= 0 ifTrue: [ 
		  newPosition := self
			                 move: aPosition spaceship
			                 in: aPosition position
			                 and: aPosition lap
			                 by: anAmount.
		  spaceshipIndex := self positionInPositionsOf:
			                    aPosition spaceship.
		  positions
			  replaceFrom: spaceshipIndex
			  to: spaceshipIndex
			  with: { newPosition } ]
]

{ #category : #movement }
Board >> moveSpaceship: aNumberOfBoxes [

	| spaceshipPlaying |
	spaceshipPlaying := (positions at: turnHandler index) spaceship.
	self move: spaceshipPlaying by: aNumberOfBoxes
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
				ifTrue: [ ^ positionToMove ] ]
		ifFalse: [ 
			positionToMove <= winningPosition
				ifFalse: [ ^ winningPosition ]
				ifTrue: [ ^ positionToMove ] ]
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
		             SpacechipPosition following: spaceship name ].
	turnHandler := SequenceHandler for: spaceships size.
	boxParsecLength := parsecsLength / aNumberOfBoxes
]

{ #category : #playing }
Board >> positionInPositionsOf: aSpaceship [

	| currentPosition |
	currentPosition := (positions select: [ :position | 
		                    position spaceship = aSpaceship ]) at: 1.
	^ positions indexOf: currentPosition
]

{ #category : #accessing }
Board >> positionOf: aSpaceship [

   ^ (positions detect: [ :position | position spaceship = aSpaceship ]) position
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

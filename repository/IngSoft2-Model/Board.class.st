Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'boxes',
		'turnHandler',
		'positions',
		'laps',
		'boardUnitLength',
		'game',
		'lastBox',
		'deck'
	],
	#category : #'IngSoft2-Model'
}

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

{ #category : #'instance creation' }
Board class >> of: aNumberOfBoxes and: length playedFor: someLaps givenBy: aDistribution [

	| randomBoxGenerator boxSequnce |
	self assertValidNumberOfBoxes: aNumberOfBoxes.
	self assertValidNumberOfLaps: someLaps.
	randomBoxGenerator := RandomEventGenerator
		                      with: aNumberOfBoxes
		                      using: aDistribution.
	boxSequnce := randomBoxGenerator generate collect: [ :effect | 
		              Box with: effect ].
	^ self new
		  of: aNumberOfBoxes
		  and: length
		  playedFor: someLaps
		  with: boxSequnce
]

{ #category : #'instance creation' }
Board class >> of: aNumberOfBoxes and: aLength playedFor: someLaps with: aBoxSequence [

	self assertValidNumberOfBoxes: aNumberOfBoxes.
	self assertValidNumberOfLaps: someLaps.
	^ self new
		  of: aNumberOfBoxes
		  and: aLength
		  playedFor: someLaps
		  with: aBoxSequence
]

{ #category : #properties }
Board >> amountOfAtomicBombBoxes [

	^ self amountOfBoxes: 'Atomic Bomb'
]

{ #category : #properties }
Board >> amountOfBoxes [

	^ boxes size
]

{ #category : #properties }
Board >> amountOfBoxes: aType [

	^ (boxes select: [ :box | box effectType = aType ]) size
]

{ #category : #properties }
Board >> amountOfHyperJumpBoxes [

	^ self amountOfBoxes: 'HyperJump'
]

{ #category : #properties }
Board >> amountOfMoonWalkBoxes [

	^ self amountOfBoxes: 'MoonWalk'
]

{ #category : #properties }
Board >> amountOfNoEffectBoxes [

	^ self amountOfBoxes: 'No Effect'
]

{ #category : #properties }
Board >> amountOfSpeedUpBoxes [

	^ self amountOfBoxes: 'Speedup'
]

{ #category : #properties }
Board >> amountOfWormHoleBoxes [

	^ self amountOfBoxes: 'WormHole'
]

{ #category : #asserting }
Board >> assertACardCanBeThrown [

	self thereIsAWinner ifTrue: [ 
		Error signal: 'Cards can only be thrown if game has not finished' ]
]

{ #category : #asserting }
Board >> assertThisIsPlayersTurn: index [

	(turnHandler assertSequenceIndexIs: index) ifFalse: [ 
		Error signal: 'This is not the players turn' ]
]

{ #category : #playing }
Board >> assign: aCard to: aSpaceship [

	game addHolding:
		(SpaceshipCardHolder
			 of: aSpaceship
			 holding: aCard)
]

{ #category : #playing }
Board >> assignToCurrentSpaceship: aCard [

	self assign: aCard to: self lastSpacechipToHavePlayed
]

{ #category : #accessing }
Board >> boardUnitLength [

	^ boardUnitLength
]

{ #category : #accessing }
Board >> boxLigthYearLength [

	^ boardUnitLength inLightYears / boxes size
]

{ #category : #accessing }
Board >> boxParsecLength [

	^ boardUnitLength inParsecs / boxes size
]

{ #category : #accessing }
Board >> boxPositionOf: aSpaceship [

	^ (self positionOf: aSpaceship) position
]

{ #category : #playing }
Board >> dealCard [

	| card |
	game cardCanBeDealt ifTrue: [ 
		card := game dealCard.
		self assignToCurrentSpaceship: card ]
]

{ #category : #playing }
Board >> dealCardTo: aSpacechip [ 
	| card |
	card := game dealCard.
	self assign: card to: aSpacechip
]

{ #category : #validation }
Board >> isSpaceshipsTurn: aSpaceship [

	^ turnHandler assertCurrentIndexIs:
		  (self positionInPositionsOf: aSpaceship)
]

{ #category : #accessing }
Board >> lapOf: aSpaceship [

	^ (self positionOf: aSpaceship) lap
]

{ #category : #accessing }
Board >> lastBox [

	^ lastBox
]

{ #category : #accessing }
Board >> lastSpacechipToHavePlayed [

	^ (positions at: turnHandler sequenceValueInUse) spaceship
]

{ #category : #movement }
Board >> move: aSpaceship by: aNumberOfBoxes [

	| newPositionWithoutEffect positionAmongPositions currentBox movementAfterEffect currentBoardPosition currentLap newPositionAfterEffect |
	positionAmongPositions := self positionInPositionsOf: aSpaceship.
	self assertThisIsPlayersTurn: positionAmongPositions.
	
	currentBoardPosition := (positions at: positionAmongPositions)
		                        position.
	currentLap := (positions at: positionAmongPositions) lap.
	newPositionWithoutEffect := self
		                            move: aSpaceship
		                            in: currentBoardPosition
		                            and: currentLap
		                            by: aNumberOfBoxes.

	newPositionWithoutEffect position > boxes size ifTrue: [ 
		positions
			replaceFrom: positionAmongPositions
			to: positionAmongPositions
			with: { newPositionWithoutEffect }.
		^ self ].
	currentBox := boxes at: newPositionWithoutEffect position.
	lastBox := currentBox.
	movementAfterEffect := currentBox applyEffectOn: self.
	movementAfterEffect = 'Do not move'
		ifFalse: [ 
			newPositionAfterEffect := self
				                          move: aSpaceship
				                          in: newPositionWithoutEffect position
				                          and: newPositionWithoutEffect lap
				                          by: movementAfterEffect ]
		ifTrue: [ ^ self ].
	positions
		replaceFrom: positionAmongPositions
		to: positionAmongPositions
		with: { newPositionAfterEffect }
]

{ #category : #movement }
Board >> move: aSpaceship in: aPosition and: aLap by: aNumberOfBoxes [

	| positionToMove newPosition |
	positionToMove := self
		                  nextPositionStartingAt: aPosition
		                  in: aLap
		                  afterMoving: aNumberOfBoxes.
	newPosition := positionToMove = -1
		               ifFalse: [ 
			               positionToMove = 0
				               ifFalse: [ 
					               SpaceshipPosition
						               following: aSpaceship
						               at: (BoardPosition at: positionToMove in: aLap) ]
				               ifTrue: [ 
					               SpaceshipPosition
						               following: aSpaceship
						               at: (BoardPosition at: 1 in: aLap) ] ]
		               ifTrue: [ 
			               SpaceshipPosition
				               following: aSpaceship
				               at: (BoardPosition at: 1 in: aLap + 1) ].
	^ newPosition
]

{ #category : #movement }
Board >> moveAllBackToBeginning [

	positions size timesRepeat: [ 
		| currentPosition |
		currentPosition := positions at: turnHandler nextValue.
		self
			movePlayingSpaceshipAt: currentPosition
			by: 1 - currentPosition position ]
]

{ #category : #movement }
Board >> moveAllExcept: aSpaceship by: anAmount [

	positions do: [ :position | 
		position spaceship = aSpaceship ifFalse: [ 
			self movePlayingSpaceshipAt: position by: anAmount ] ]
]

{ #category : #movement }
Board >> moveAllExceptCurrentBy: anAmount [

	self moveAllExcept: turnHandler sequenceValueInUse by: anAmount
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
		  spaceshipIndex := self positionInPositionsOf: aPosition spaceship.
		  positions
			  replaceFrom: spaceshipIndex
			  to: spaceshipIndex
			  with: { newPosition } ]
]

{ #category : #movement }
Board >> moveSpaceship: aNumberOfBoxes [

	| spaceshipPlaying |
	spaceshipPlaying := (positions at: turnHandler nextValue) spaceship.
	self move: spaceshipPlaying by: aNumberOfBoxes
]

{ #category : #asserting }
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
Board >> of: aNumberOfBoxes and: aLength playedFor: someLaps with: aBoxSequence [

	| sequenceHandler |
	boxes := OrderedCollection new.
	sequenceHandler := SequenceHandler for: aBoxSequence size.
	aNumberOfBoxes timesRepeat: [ 
		boxes add: (aBoxSequence at: sequenceHandler nextValue) ].
	laps := someLaps.
	boardUnitLength := aLength.
	lastBox := Box with: NoEffect new
]

{ #category : #properties }
Board >> playingWith: spaceships in: aGame [

	game := aGame.
	positions := spaceships collect: [ :spaceship | 
		             SpaceshipPosition following: spaceship ].
	turnHandler := SequenceHandler for: spaceships size
]

{ #category : #playing }
Board >> positionInPositionsOf: aSpaceship [

	| currentPosition |
	currentPosition := self positionOf: aSpaceship.
	^ positions indexOf: currentPosition
]

{ #category : #accessing }
Board >> positionOf: aSpaceship [

	^ positions detect: [ :position | position spaceship = aSpaceship ]
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

{ #category : #accessing }
Board >> spaceshipPlaying [

	^ (positions at: turnHandler currentIndex) spaceship
]

{ #category : #properties }
Board >> thereIsAWinner [

	^ positions anySatisfy: [ :boardPosition | 
		  (boardPosition position > self amountOfBoxes
		  and: [boardPosition lap = laps]) or: [boardPosition lap > laps]]
]

{ #category : #properties }
Board >> winner [

	| winnerSpaceship |
	winnerSpaceship := (positions select: [ :spaceship | 
		                    spaceship position > self amountOfBoxes ]) at: 1.
	^ winnerSpaceship spaceship
]

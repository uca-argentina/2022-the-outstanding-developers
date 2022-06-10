Class {
	#name : #OutstandingSpaceshipsGameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
OutstandingSpaceshipsGameTest >> should: block raise: expectedErrorClass withMessage: expectedErrorMessage [

	self
		should: block
		raise: expectedErrorClass
		whoseDescriptionIncludes: expectedErrorMessage
		description: 'Test did not fail as expected'
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testANonSimulatedGameCannotBePlayedAfterItFinished [

	| aSpaceship anotherSpaceship board aDie game |
	aSpaceship := Spaceship called: 'SP1'.
	anotherSpaceship := Spaceship called: 'SP2'.
	board := Board
		         of: 7
		         and: 7
		         playedFor: 1
		         byMany: { 
				         aSpaceship.
				         anotherSpaceship }
		         with: { (Box with: NoEffect new) }.
	aDie := LoadedDie withSequence: { 4. 3 }.
	game := OutstandingSpaceshipsGame playedOn: board throwing: aDie.

	game play.
	game play.
	game play.

	self
		should: [ game play ]
		raise: Error
		withMessage: 'The game has already been finished'
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testARoundOfANonSimulatedGameChangesSpaceshipsPosition [

	| aSpaceship anotherSpaceship board aDie game |
	aSpaceship := Spaceship called: 'SP1'.
	anotherSpaceship := Spaceship called: 'SP2'.
	board := Board
		         of: 15
					and: 15
		         playedFor: 1
		         byMany: { 
				         aSpaceship.
				         anotherSpaceship }
		         with: { (Box with: NoEffect new) }.
	aDie := LoadedDie withSequence: { 4. 3 }.
	game := OutstandingSpaceshipsGame playedOn: board throwing: aDie.

	game play.
	game play.

	self assert: (board positionOf: aSpaceship name) equals: 4.
	self assert: (board positionOf: anotherSpaceship name) equals: 3
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testGameCanBeWonAndRankingCanBeShown [

	| aSpaceship anotherSpaceship aBoard aDie game otherSpaceship |
	aSpaceship := Spaceship called: 'Player1'.
	anotherSpaceship := Spaceship called: 'Player2'.
	otherSpaceship := Spaceship called: 'Player3'.
	aBoard := Board
		          of: 15
					 and: 15
		          playedFor: 3
		          byMany: { 
				          aSpaceship.
				          anotherSpaceship. otherSpaceship }
		          with: { (Box with: NoEffect new) }.
	aDie := LoadedDie withSequence: {5. 1. 2}.
	game := OutstandingSpaceshipsGame playedOn: aBoard throwing: aDie.

	game startSimulation.

	self assert: (aBoard rankingPositionOf: 'Player2') equals: 3.
	self assert: (aBoard rankingPositionOf: 'Player1') equals: 1.
	self assert: (aBoard rankingPositionOf: 'Player3') equals: 2.
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testGameWithABoardOfFifteenBoxesALoadedDieAndASpaceshipEndsWithFinalPositionOfSixteen [

	| aSpaceship aBoard aDie game |
	aSpaceship := Spaceship called: 'Player1'.
	aBoard := Board
		          of: 15
		          and: 15
		          playedFor: 1
		          by: aSpaceship
		          with: { (Box with: NoEffect new) }.
	aDie := LoadedDie with: 5.
	game := OutstandingSpaceshipsGame playedOn: aBoard throwing: aDie.

	game startSimulation.

	self assert: (aBoard positionOf: 'Player1') equals: 16
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testGameWithAFiniteBoardASequenceLoadedDieAndThreeShipsIsWonAfterThreeLapsAndPlayersHaveSpecificPositions [

	| aSpaceship anotherSpaceship aBoard aDie game otherSpaceship |
	aSpaceship := Spaceship called: 'Player1'.
	anotherSpaceship := Spaceship called: 'Player2'.
	otherSpaceship := Spaceship called: 'Player3'.
	aBoard := Board
		          of: 10
		          and: 10
		          playedFor: 3
		          byMany: { 
				          aSpaceship.
				          anotherSpaceship.
				          otherSpaceship }
		          with: { (Box with: NoEffect new) }.
	aDie := LoadedDie withSequence: { 1. 4. 3 }.
	game := OutstandingSpaceshipsGame playedOn: aBoard throwing: aDie.

	game startSimulation.

	self assert: (aBoard positionOf: 'Player1') equals: 9.
	self assert: (aBoard positionOf: 'Player2') equals: 11.
	self assert: (aBoard positionOf: 'Player3') equals: 1
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testGameWithAFiniteBoardASequenceLoadedDieAndThreeShipsIsWonAndPlayersHaveSpecificPositions [

	| aSpaceship anotherSpaceship aBoard aDie game otherSpaceship |
	aSpaceship := Spaceship called: 'Player1'.
	anotherSpaceship := Spaceship called: 'Player2'.
	otherSpaceship := Spaceship called: 'Player3'.
	aBoard := Board
		          of: 10
		          and: 10
		          playedFor: 1
		          byMany: { 
				          aSpaceship.
				          anotherSpaceship.
				          otherSpaceship }
		          with: { (Box with: NoEffect new) }.
	aDie := LoadedDie withSequence: { 1. 4. 3 }.
	game := OutstandingSpaceshipsGame playedOn: aBoard throwing: aDie.

	game startSimulation.

	self assert: (aBoard positionOf: 'Player1') equals: 3.
	self assert: (aBoard positionOf: 'Player2') equals: 11.
	self assert: (aBoard positionOf: 'Player3') equals: 6
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testGameWithASpaceshipABoardWithFiveBoxesAndALoadedDieWithFourDoesNotEndAfterOneRoll [

	| aBoard aDice spaceship game resultOfTheRoll |
	spaceship := Spaceship called: 'APlayerName'.
	aBoard := Board
		          of: 5
		          and: 5
		          playedFor: 1
		          by: spaceship
		          with: { (Box with: NoEffect new) }.
	aDice := LoadedDie with: 4.

	game := OutstandingSpaceshipsGame playedOn: aBoard throwing: aDice.
	resultOfTheRoll := aDice roll.
	aBoard moveSpaceship: resultOfTheRoll.

	self deny: game thereIsAWinner
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testGameWithASpaceshipAndABoardEndsWhenItCompletesThreeLaps [

	| aSpaceship aBoard aDie game |
	aSpaceship := Spaceship called: 'Player1'.
	aBoard := Board
		          of: 15
		          and: 15
		          playedFor: 3
		          by: aSpaceship
		          with: { (Box with: NoEffect new) }.
	aDie := LoadedDie with: 5.
	game := OutstandingSpaceshipsGame playedOn: aBoard throwing: aDie.

	game startSimulation.

	self assert: (aBoard positionOf: 'Player1') equals: 16.
	self assert: (aBoard lapOf: 'Player1') equals: 3
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testGameWithSpaceshipsAFiniteBoardAndADiceCupEnds [

	| aSpaceship anotherSpaceship aBoard aDie game anotherDie otherDie aDiceCup |
	aSpaceship := Spaceship called: 'Player1'.
	anotherSpaceship := Spaceship called: 'Player2'.
	aBoard := Board
		          of: 50
		          and: 50
		          playedFor: 3
		          byMany: { 
				          aSpaceship.
				          anotherSpaceship }
		          with: { (Box with: NoEffect new) }.
	aDie := Die with: 4.
	anotherDie := Die with: 5.
	otherDie := Die with: 6.
	aDiceCup := DiceCup withAll: { 
			            aDie.
			            anotherDie.
			            otherDie }.
	game := OutstandingSpaceshipsGame playedOn: aBoard throwing: aDiceCup.

	game startSimulation.

	self assert: game thereIsAWinner
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testGameWithSpaceshipsAFiniteBoardAndADieEnds [

	| aSpaceship anotherSpaceship aBoard aDie game |
	aSpaceship := Spaceship called: 'Player1'.
	anotherSpaceship := Spaceship called: 'Player2'.
	aBoard := Board
		          of: 15
		          and: 15
		          playedFor: 2
		          byMany: { 
				          aSpaceship.
				          anotherSpaceship }
		          with: { (Box with: NoEffect new) }.
	aDie := Die with: 4.
	game := OutstandingSpaceshipsGame playedOn: aBoard throwing: aDie.

	game startSimulation.

	self assert: game thereIsAWinner
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testGameWithSpaceshipsAFiniteBoardAndALoadedDieEnds [

	| aSpaceship anotherSpaceship aBoard aLoadedDie game resultOfTheRoll |
	aSpaceship := Spaceship called: 'Player1'.
	anotherSpaceship := Spaceship called: 'Player2'.
	aBoard := Board
		          of: 5
		          and: 5
		          playedFor: 1
		          byMany: { 
				          aSpaceship.
				          anotherSpaceship }
		          with: { (Box with: NoEffect new) }.
	aLoadedDie := LoadedDie with: 3.
	game := OutstandingSpaceshipsGame
		        playedOn: aBoard
		        throwing: aLoadedDie.

	game play.
	game play.
	game play.

	self assert: game thereIsAWinner
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testGameWithSpaceshipsAFiniteBoardAndASequencedLoadedDieHasTheSecondPlayerAsTheWinner [

	| aSpaceship anotherSpaceship aBoard aDie game |
	aSpaceship := Spaceship called: 'Player1'.
	anotherSpaceship := Spaceship called: 'Player2'.
	aBoard := Board
		          of: 15
		          and: 15
		          playedFor: 2
		          byMany: { 
				          aSpaceship.
				          anotherSpaceship }
		          with: { (Box with: NoEffect new) }.
	aDie := LoadedDie withSequence: { 1. 3 }.
	game := OutstandingSpaceshipsGame playedOn: aBoard throwing: aDie.

	game startSimulation.

	self assert: game winner equals: 'Player2'
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testGameWithSpaceshipsAFiniteBoardAndLoadedDieHasBothSpaceshipsPositionChangeUntilItEnds [

	| aSpaceship anotherSpaceship aBoard aDie game |
	aSpaceship := Spaceship called: 'Player1'.
	anotherSpaceship := Spaceship called: 'Player2'.
	aBoard := Board
		          of: 15
		          and: 15
		          playedFor: 1
		          byMany: { 
				          aSpaceship.
				          anotherSpaceship }
		          with: { (Box with: NoEffect new) }.
	aDie := LoadedDie with: 4.
	game := OutstandingSpaceshipsGame playedOn: aBoard throwing: aDie.

	game startSimulation.

	self assert: (aBoard positionOf: 'Player1') equals: 16.
	self assert: (aBoard positionOf: 'Player2') equals: 12
]

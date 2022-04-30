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
	board := Board of: 7 playedByMany: { 
			         aSpaceship.
			         anotherSpaceship }.
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
	board := Board of: 15 playedByMany: { 
			          aSpaceship.
			          anotherSpaceship }.
	aDie := LoadedDie withSequence: {4. 3}.
	game := OutstandingSpaceshipsGame playedOn: board throwing: aDie.

	game play.
	game play.

	self assert: (board positionOf: aSpaceship name) equals: 4.
	self assert: (board positionOf: anotherSpaceship name) equals: 3.
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testGameWithABoardOfFifteenBoxesALoadedDieAndASpaceshipEndsWithFinalPositionOfSixteen [

	| aSpaceship aBoard aDie game |
	aSpaceship := Spaceship called: 'Player1'.
	aBoard := Board of: 15 playedBy: aSpaceship.
	aDie := LoadedDie with: 5.
	game := OutstandingSpaceshipsGame playedOn: aBoard throwing: aDie.

	game startSimulation.

	self assert: (aBoard positionOf: 'Player1') equals: 16
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testGameWithAFiniteBoardASequenceLoadedDieAndThreeShipsIsWonAndPlayersHaveSpecificPositions [

	| aSpaceship anotherSpaceship aBoard aDie game otherSpaceship |
	aSpaceship := Spaceship called: 'Player1'.
	anotherSpaceship := Spaceship called: 'Player2'.
	otherSpaceship := Spaceship called: 'Player3'.
	aBoard := Board of: 10 playedByMany: { 
			          aSpaceship.
			          anotherSpaceship.
			          otherSpaceship }.
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
	aBoard := Board of: 5 playedBy: spaceship.
	aDice := LoadedDie with: 4.

	game := OutstandingSpaceshipsGame playedOn: aBoard throwing: aDice.
	resultOfTheRoll := aDice roll.
	aBoard moveSpaceship: resultOfTheRoll.

	self deny: game thereIsAWinner
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testGameWithSpaceshipsAFiniteBoardAndADiceCupEnds [

	| aSpaceship anotherSpaceship aBoard aDie game anotherDie otherDie aDiceCup |
	aSpaceship := Spaceship called: 'Player1'.
	anotherSpaceship := Spaceship called: 'Player2'.
	aBoard := Board of: 50 playedByMany: { 
			          aSpaceship.
			          anotherSpaceship }.
	aDie := Die with: 4.
	anotherDie := Die with: 5.
	otherDie := Die with: 6.
	aDiceCup := DiceCup withAll: { 
			            aDie.
			            anotherDie.
			            otherDie }.
	game := OutstandingSpaceshipsGame
		        playedOn: aBoard
		        throwing: aDiceCup.

	game startSimulation.

	self assert: game thereIsAWinner
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testGameWithSpaceshipsAFiniteBoardAndADieEnds [

	| aSpaceship anotherSpaceship aBoard aDie game |
	aSpaceship := Spaceship called: 'Player1'.
	anotherSpaceship := Spaceship called: 'Player2'.
	aBoard := Board of: 15 playedByMany: { 
			          aSpaceship.
			          anotherSpaceship }.
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
	aBoard := Board of: 5 playedByMany: { 
			          aSpaceship.
			          anotherSpaceship }.
	aLoadedDie := LoadedDie with: 3.
	game := OutstandingSpaceshipsGame
		        playedOn: aBoard
		        throwing: aLoadedDie.

	resultOfTheRoll := aLoadedDie roll.
	aBoard moveSpaceship: resultOfTheRoll.
	aBoard moveSpaceship: resultOfTheRoll.
	aBoard moveSpaceship: resultOfTheRoll.

	self assert: game thereIsAWinner
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testGameWithSpaceshipsAFiniteBoardAndASequencedLoadedDieHasTheSecondPlayerAsTheWinner [

	| aSpaceship anotherSpaceship aBoard aDie game |
	aSpaceship := Spaceship called: 'Player1'.
	anotherSpaceship := Spaceship called: 'Player2'.
	aBoard := Board of: 15 playedByMany: { 
			          aSpaceship.
			          anotherSpaceship }.
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
	aBoard := Board of: 15 playedByMany: { 
			          aSpaceship.
			          anotherSpaceship }.
	aDie := LoadedDie with: 4.
	game := OutstandingSpaceshipsGame playedOn: aBoard throwing: aDie.

	game startSimulation.

	self assert: (aBoard positionOf: 'Player1') equals: 16.
	self assert: (aBoard positionOf: 'Player2') equals: 12
]
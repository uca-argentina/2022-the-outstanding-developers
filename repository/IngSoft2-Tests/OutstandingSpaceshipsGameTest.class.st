Class {
	#name : #OutstandingSpaceshipsGameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testGameWithABoardOfFifteenBoxesALoadedDieAndASpaceshipEndsWithFinalPositionOfSixteen [

	| aSpaceship aBoard aDie game |
	aSpaceship := Spaceship called: 'Player1'.
	aBoard := Board of: 15 playedBy: aSpaceship.
	aDie := LoadedDie with: 5.
	game := OutstandingSpaceshipsGame withABoard: aBoard andDice: aDie.

	game start.

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
	game := OutstandingSpaceshipsGame withABoard: aBoard andDice: aDie.

	game start.

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

	game := OutstandingSpaceshipsGame withABoard: aBoard andDice: aDice.
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
	aDie := RandomDie with: 4.
	anotherDie := RandomDie with: 5.
	otherDie := RandomDie with: 6.
	aDiceCup := DiceCup withAll: { 
			            aDie.
			            anotherDie.
			            otherDie }.
	game := OutstandingSpaceshipsGame
		        withABoard: aBoard
		        andDice: aDiceCup.

	game start.

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
	aDie := RandomDie with: 4.
	game := OutstandingSpaceshipsGame withABoard: aBoard andDice: aDie.

	game start.

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
		        withABoard: aBoard
		        andDice: aLoadedDie.

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
	game := OutstandingSpaceshipsGame withABoard: aBoard andDice: aDie.

	game start.

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
	game := OutstandingSpaceshipsGame withABoard: aBoard andDice: aDie.

	game start.

	self assert: (aBoard positionOf: 'Player1') equals: 16.
	self assert: (aBoard positionOf: 'Player2') equals: 12
]

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

	| enterprise zathura board aDie game |
	enterprise := Spaceship called: 'Enterprise'.
	zathura := Spaceship called: 'Zathura'.
	board := Board
		         of: 7
		         and: 7
		         playedFor: 1
		         byMany: { 
				         enterprise.
				         zathura }
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

	| enterprise zathura board aDie game |
	enterprise := Spaceship called: 'Enterprise'.
	zathura := Spaceship called: 'Zathura'.
	board := Board
		         of: 15
		         and: 15
		         playedFor: 1
		         byMany: { 
				         enterprise.
				         zathura }
		         with: { (Box with: NoEffect new) }.
	aDie := LoadedDie withSequence: { 4. 3 }.
	game := OutstandingSpaceshipsGame playedOn: board throwing: aDie.

	game play.
	game play.

	self assert: (board positionOf: enterprise name) equals: 4.
	self assert: (board positionOf: zathura name) equals: 3
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testGameCanBeWonAndRankingCanBeShown [

	| zathura enterprise aBoard aDie game delorean |
	zathura := Spaceship called: 'Zathura'.
	enterprise := Spaceship called: 'Enterprise'.
	delorean := Spaceship called: 'Delorean'.
	aBoard := Board
		          of: 15
		          and: 15
		          playedFor: 3
		          byMany: { 
				          zathura.
				          enterprise.
				          delorean }
		          with: { (Box with: NoEffect new) }.
	aDie := LoadedDie withSequence: { 5. 1. 2 }.
	game := OutstandingSpaceshipsGame playedOn: aBoard throwing: aDie.

	game startSimulation.

	self assert: (aBoard rankingPositionOf: 'Enterprise') equals: 3.
	self assert: (aBoard rankingPositionOf: 'Zathura') equals: 1.
	self assert: (aBoard rankingPositionOf: 'Delorean') equals: 2
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testGameWithABoardOfFifteenBoxesALoadedDieAndASpaceshipEndsWithFinalPositionOfSixteen [

	| enterprise aBoard aDie game |
	enterprise := Spaceship called: 'Enterprise'.
	aBoard := Board
		          of: 15
		          and: 15
		          playedFor: 1
		          by: enterprise
		          with: { (Box with: NoEffect new) }.
	aDie := LoadedDie with: 5.
	game := OutstandingSpaceshipsGame playedOn: aBoard throwing: aDie.

	game startSimulation.

	self assert: (aBoard positionOf: 'Enterprise') equals: 16
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testGameWithAFiniteBoardASequenceLoadedDieAndThreeShipsIsWonAfterThreeLapsAndPlayersHaveSpecificPositions [

	| zathura enterprise aBoard aDie game delorean |
	zathura := Spaceship called: 'Zathura'.
	enterprise := Spaceship called: 'Enterprise'.
	delorean := Spaceship called: 'Delorean'.
	aBoard := Board
		          of: 10
		          and: 10
		          playedFor: 3
		          byMany: { 
				          zathura.
				          enterprise.
				          delorean }
		          with: { (Box with: NoEffect new) }.
	aDie := LoadedDie withSequence: { 1. 4. 3 }.
	game := OutstandingSpaceshipsGame playedOn: aBoard throwing: aDie.

	game startSimulation.

	self assert: (aBoard positionOf: 'Zathura') equals: 9.
	self assert: (aBoard positionOf: 'Enterprise') equals: 11.
	self assert: (aBoard positionOf: 'Delorean') equals: 1
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testGameWithAFiniteBoardASequenceLoadedDieAndThreeShipsIsWonAndPlayersHaveSpecificPositions [

	| enterprise delorean aBoard aDie game zathura |
	enterprise := Spaceship called: 'Enterprise'.
	delorean := Spaceship called: 'Delorean'.
	zathura := Spaceship called: 'Zathura'.
	aBoard := Board
		          of: 10
		          and: 10
		          playedFor: 1
		          byMany: { 
				          enterprise.
				          delorean.
				          zathura }
		          with: { (Box with: NoEffect new) }.
	aDie := LoadedDie withSequence: { 1. 4. 3 }.
	game := OutstandingSpaceshipsGame playedOn: aBoard throwing: aDie.

	game startSimulation.

	self assert: (aBoard positionOf: 'Enterprise') equals: 3.
	self assert: (aBoard positionOf: 'Delorean') equals: 11.
	self assert: (aBoard positionOf: 'Zathura') equals: 6
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testGameWithASpaceshipABoardWithFiveBoxesAndALoadedDieWithFourDoesNotEndAfterOneRoll [

	| aBoard aDice enterprise game resultOfTheRoll |
	enterprise := Spaceship called: 'Enterprise'.
	aBoard := Board
		          of: 5
		          and: 5
		          playedFor: 1
		          by: enterprise
		          with: { (Box with: NoEffect new) }.
	aDice := LoadedDie with: 4.

	game := OutstandingSpaceshipsGame playedOn: aBoard throwing: aDice.
	resultOfTheRoll := aDice roll.
	aBoard moveSpaceship: resultOfTheRoll.

	self deny: game thereIsAWinner
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testGameWithASpaceshipAndABoardEndsWhenItCompletesThreeLaps [

	| enterprise aBoard aDie game |
	enterprise := Spaceship called: 'Enterprise'.
	aBoard := Board
		          of: 15
		          and: 15
		          playedFor: 3
		          by: enterprise
		          with: { (Box with: NoEffect new) }.
	aDie := LoadedDie with: 5.
	game := OutstandingSpaceshipsGame playedOn: aBoard throwing: aDie.

	game startSimulation.

	self assert: (aBoard positionOf: 'Enterprise') equals: 16.
	self assert: (aBoard lapOf: 'Enterprise') equals: 3
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testGameWithSpaceshipsAFiniteBoardAndADiceCupEnds [

	| delorean enterprise aBoard aDie game anotherDie otherDie aDiceCup |
	delorean := Spaceship called: 'Delorean'.
	enterprise := Spaceship called: 'Enterprise'.
	aBoard := Board
		          of: 50
		          and: 50
		          playedFor: 3
		          byMany: { 
				          delorean.
				          enterprise }
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

	| zathura delorean aBoard aDie game |
	zathura := Spaceship called: 'Zathura'.
	delorean := Spaceship called: 'Delorean'.
	aBoard := Board
		          of: 15
		          and: 15
		          playedFor: 2
		          byMany: { 
				          zathura.
				          delorean }
		          with: { (Box with: NoEffect new) }.
	aDie := Die with: 4.
	game := OutstandingSpaceshipsGame playedOn: aBoard throwing: aDie.

	game startSimulation.

	self assert: game thereIsAWinner
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testGameWithSpaceshipsAFiniteBoardAndALoadedDieEnds [

	| enterprise zathura aBoard aLoadedDie game |
	enterprise := Spaceship called: 'Enterprise'.
	zathura := Spaceship called: 'Zathura'.
	aBoard := Board
		          of: 5
		          and: 5
		          playedFor: 1
		          byMany: { 
				          enterprise.
				          zathura }
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
	aSpaceship := Spaceship called: 'Enterprise'.
	anotherSpaceship := Spaceship called: 'Zathura'.
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

	self assert: game winner equals: 'Zathura'
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testGameWithSpaceshipsAFiniteBoardAndLoadedDieHasBothSpaceshipsPositionChangeUntilItEnds [

	| zathura enterprise aBoard aDie game |
	zathura := Spaceship called: 'Zathura'.
	enterprise := Spaceship called: 'Enterprise'.
	aBoard := Board
		          of: 15
		          and: 15
		          playedFor: 1
		          byMany: { 
				          zathura.
				          enterprise }
		          with: { (Box with: NoEffect new) }.
	aDie := LoadedDie with: 4.
	game := OutstandingSpaceshipsGame playedOn: aBoard throwing: aDie.

	game startSimulation.

	self assert: (aBoard positionOf: 'Zathura') equals: 16.
	self assert: (aBoard positionOf: 'Enterprise') equals: 12
]

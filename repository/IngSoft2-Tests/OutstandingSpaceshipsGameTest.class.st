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
OutstandingSpaceshipsGameTest >> testAGameCanBeSimulatedAndWon [

	| aBoard aCardDistribution anOutstandingGame boxDistributions n aFiniteDeck |
	n := 100.
	aCardDistribution := OrderedCollection new.

	aCardDistribution add:
		(Distribution withProbabilityOf: 1 / 6 for: SpeedCard).
	aCardDistribution add:
		(Distribution withProbabilityOf: 1 / 6 for: AccelerationCard).
	aCardDistribution add:
		(Distribution withProbabilityOf: 1 / 6 for: OverloadCard).
	aCardDistribution add:
		(Distribution withProbabilityOf: 1 / 6 for: CancellationCard).
	aCardDistribution add:
		(Distribution withProbabilityOf: 1 / 6 for: RedoCard).
	aCardDistribution add:
		(Distribution withProbabilityOf: 1 / 6 for: RepeatCard).
	aFiniteDeck := FiniteDeck of: 1000 with: aCardDistribution.
	boxDistributions := OrderedCollection new.
	boxDistributions add:
		(Distribution withProbabilityOf: 0.3 for: NoEffect).
	boxDistributions add:
		(Distribution withProbabilityOf: 0.2 for: SpeedUpEffect).
	boxDistributions add:
		(Distribution withProbabilityOf: 0.2 for: WormHoleEffect).
	boxDistributions add:
		(Distribution withProbabilityOf: 0.1 for: (MoonWalkEffect for: n)).
	boxDistributions add:
		(Distribution withProbabilityOf: 0.08 for: HyperJumpEffect).
	boxDistributions add:
		(Distribution withProbabilityOf: 0.02 for: AtomicBombEffect).
	boxDistributions add: (Distribution
			 withProbabilityOf: 0.1
			 for: (CardAwarderEffect withA: aFiniteDeck)).

	aBoard := Board
		          of: 20
		          and: (ParsecUnit of: 15)
		          playedFor: 6
		          givenBy: boxDistributions.

	aCardDistribution := OrderedCollection new.
	aCardDistribution add:
		(Distribution withProbabilityOf: 1 for: OverloadCard).

	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany:
		                     { 'Zathura'. 'Delorean'. 'Enterprise'.
		                     'Apollo11'. 'Apollo13' }
		                     on: aBoard
		                     throwing: (Die with: 7)
		                     using: aFiniteDeck.

	anOutstandingGame startSimulation.

	self assert: anOutstandingGame thereIsAWinner
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testANonSimulatedGameCannotBePlayedAfterItFinished [

	| board aDie game aCardDistribution aFiniteDeck |
	board := Board
		         of: 7
		         and: (ParsecUnit of: 7)
		         playedFor: 1
		         with: { (Box with: NoEffect new) }.
	aDie := LoadedDie withSequence: { 4. 3 }.
	aCardDistribution := OrderedCollection new.

	aCardDistribution add:
		(Distribution withProbabilityOf: 1 / 6 for: SpeedCard).
	aCardDistribution add:
		(Distribution withProbabilityOf: 1 / 6 for: AccelerationCard).
	aCardDistribution add:
		(Distribution withProbabilityOf: 1 / 6 for: OverloadCard).
	aCardDistribution add:
		(Distribution withProbabilityOf: 1 / 6 for: CancellationCard).
	aCardDistribution add:
		(Distribution withProbabilityOf: 1 / 6 for: RedoCard).
	aCardDistribution add:
		(Distribution withProbabilityOf: 1 / 6 for: RepeatCard).
	aFiniteDeck := FiniteDeck of: 100 with: aCardDistribution.
	game := OutstandingSpaceshipsGame
		        playedByMany: { 'Enterprise'. 'Zathura' }
		        on: board
		        throwing: aDie
		        using: aFiniteDeck.

	game play.
	game play.
	game play.

	self
		should: [ game play ]
		raise: Error
		withMessage: 'The game has already been finished'
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testAPermanentCardDoesntGoToTheUsedCardsDeckIfNotCancelled [

	| aBoard aFiniteDeck anOutstandingGame |
	aFiniteDeck := FiniteDeck of: 30 setWith: { OverloadCard create }.

	aBoard := Board
		          of: 20
		          and: (ParsecUnit of: 20)
		          playedFor: 1
		          with: { (Box with: NoEffect new) }.

	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Enterprise'. 'Delorean' }
		                     on: aBoard
		                     throwing: (LoadedDie withSequence: { 2. 3 })
		                     using: aFiniteDeck.

	self assert: aFiniteDeck cardAmount equals: 26.
	self assert: anOutstandingGame amountOfUsedCards equals: 0.
	anOutstandingGame
		throws: (OverloadCard thrownAt: 'Delorean')
		from: 'Enterprise'.
	self assert: aFiniteDeck cardAmount equals: 26.
	self assert: anOutstandingGame amountOfUsedCards equals: 0
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testAPermanentCardGoesToTheUsedCardsDeckIfRemoved [

	| aBoard aFiniteDeck anOutstandingGame |
	aFiniteDeck := FiniteDeck of: 30 setWith: { 
			               OverloadCard create.
			               CancellationCard create }.

	aBoard := Board
		          of: 20
		          and: (ParsecUnit of: 20)
		          playedFor: 1
		          with: { (Box with: NoEffect new) }.

	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Enterprise'. 'Delorean' }
		                     on: aBoard
		                     throwing: (LoadedDie withSequence: { 2. 3 })
		                     using: aFiniteDeck.

	self assert: aFiniteDeck cardAmount equals: 26.
	self assert: anOutstandingGame amountOfUsedCards equals: 0.
	anOutstandingGame
		throws: (OverloadCard thrownAt: 'Delorean')
		from: 'Enterprise'.
	anOutstandingGame
		throws:
		(CancellationCard thrownAt: (OverloadCard thrownAt: 'Delorean'))
		from: 'Enterprise'.
	self assert: aFiniteDeck cardAmount equals: 26.
	self assert: anOutstandingGame amountOfUsedCards equals: 2
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testARoundOfANonSimulatedGameChangesSpaceshipsPosition [

	| board aDie aCardDistribution anOutstandingGame aFiniteDeck |
	board := Board
		         of: 15
		         and: (ParsecUnit of: 15)
		         playedFor: 1
		         with: { (Box with: NoEffect new) }.
	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: OverloadCard).
	aFiniteDeck := FiniteDeck of: 100 with: aCardDistribution.
	aDie := LoadedDie withSequence: { 4. 3 }.

	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Enterprise'. 'Zathura' }
		                     on: board
		                     throwing: aDie
		                     using: aFiniteDeck.

	anOutstandingGame play.
	anOutstandingGame play.

	self assert: (board boxPositionOf: 'Enterprise') equals: 4.
	self assert: (board boxPositionOf: 'Zathura') equals: 3
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testAUsedInstantaneusCardGoesToTheUsedCardsDeckAfterbeingPlayed [

	| aBoard aFiniteDeck anOutstandingGame |
	aFiniteDeck := FiniteDeck of: 30 setWith: { RepeatCard create }.

	aBoard := Board
		          of: 20
		          and: (ParsecUnit of: 20)
		          playedFor: 1
		          with: { (Box with: NoEffect new) }.

	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Enterprise'. 'Delorean' }
		                     on: aBoard
		                     throwing: (LoadedDie withSequence: { 2. 3 })
		                     using: aFiniteDeck.

	self assert: aFiniteDeck cardAmount equals: 26.
	self assert: anOutstandingGame amountOfUsedCards equals: 0.
	anOutstandingGame
		throws: (RepeatCard thrownAt: 'Delorean')
		from: 'Enterprise'.
	self assert: aFiniteDeck cardAmount equals: 26.
	self assert: anOutstandingGame amountOfUsedCards equals: 1
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testFiniteDeckIsRefilledWithTheUsedCardDeckIfEmpty [

	| aBoard aFiniteDeck anOutstandingGame |
	aFiniteDeck := FiniteDeck of: 5 setWith: { RepeatCard create }.

	aBoard := Board
		          of: 20
		          and: (ParsecUnit of: 20)
		          playedFor: 1
		          with:
		          { (Box with: (CardAwarderEffect associatedTo: aFiniteDeck)) }.

	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Enterprise'. 'Delorean' }
		                     on: aBoard
		                     throwing: (LoadedDie withSequence: { 2. 3 })
		                     using: aFiniteDeck.

	self assert: aFiniteDeck cardAmount equals: 1.
	self assert: anOutstandingGame amountOfUsedCards equals: 0.
	anOutstandingGame
		throws: (RepeatCard thrownAt: 'Delorean')
		from: 'Enterprise'.
	self assert: aFiniteDeck cardAmount equals: 1.
	self assert: anOutstandingGame amountOfUsedCards equals: 1.
	anOutstandingGame play.
	self assert: aFiniteDeck cardAmount equals: 1.
	self assert: anOutstandingGame amountOfUsedCards equals: 0
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testGameCanBeWonAndRankingCanBeShown [

	| aBoard aDie anOutstandingGame aCardDistribution aFiniteDeck |
	aBoard := Board
		          of: 15
		          and: (ParsecUnit of: 15)
		          playedFor: 3
		          with: { (Box with: NoEffect new) }.
	aDie := LoadedDie withSequence: { 5. 1. 2 }.
	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: OverloadCard).
	aFiniteDeck := FiniteDeck of: 100 with: aCardDistribution.
	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany:
		                     { 'Enterprise'. 'Zathura'. 'Delorean' }
		                     on: aBoard
		                     throwing: aDie
		                     using: aFiniteDeck.

	anOutstandingGame startSimulation.

	self assert: (aBoard rankingPositionOf: 'Enterprise') equals: 1.
	self assert: (aBoard rankingPositionOf: 'Zathura') equals: 3.
	self assert: (aBoard rankingPositionOf: 'Delorean') equals: 2
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testGameCannotBeCreatedWithRepeatedSpaceships [

	| distributions aBoard aDie aCardDistribution |
	distributions := OrderedCollection new.
	distributions add: (Distribution withProbabilityOf: 1 for: NoEffect).
	aBoard := Board
		          of: 15
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          givenBy: distributions.
	aDie := Die with: 6.
	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: OverloadCard).

	self
		should: [ 
			OutstandingSpaceshipsGame
				playedByMany: { 'Enterprise'. 'Enterprise' }
				on: aBoard
				throwing: aDie
				using: aCardDistribution ]
		raise: Error
		withMessage: 'Spaceships must be assigned to different players'
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testGameCannotBeCreatedWithoutSpaceships [

	| distributions aBoard aDie aCardDistribution |
	distributions := OrderedCollection new.
	distributions add: (Distribution withProbabilityOf: 1 for: NoEffect).
	aBoard := Board
		          of: 15
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          givenBy: distributions.
	aDie := Die with: 6.
	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: OverloadCard).

	self
		should: [ 
			OutstandingSpaceshipsGame
				playedByMany: {  }
				on: aBoard
				throwing: aDie
				using: aCardDistribution ]
		raise: Error
		withMessage: 'Must use at least one spaceship'
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testGameGivesTwoRandomCardsToEachSpaceshipAtTheBegining [

	| aBoard aLoadedDie anOustandingGame aCardDistribution aFiniteDeck |
	aBoard := Board
		          of: 15
		          and: (ParsecUnit of: 15)
		          playedFor: 2
		          with: { (Box with: NoEffect new) }.
	aLoadedDie := LoadedDie with: 4.

	aCardDistribution := OrderedCollection new.

	aCardDistribution add: (Distribution
			 withProbabilityOf: 1 / 6
			 for: SpeedCard).
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1 / 6
			 for: AccelerationCard).
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1 / 6
			 for: OverloadCard).
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1 / 6
			 for: CancellationCard).
	aCardDistribution add:
		(Distribution withProbabilityOf: 1 / 6 for: RedoCard).
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1 / 6
			 for: RepeatCard).
	aFiniteDeck := FiniteDeck of: 100 with: aCardDistribution.
	anOustandingGame := OutstandingSpaceshipsGame
		                    playedByMany: { 'Delorean'. 'Enterprise' }
		                    on: aBoard
		                    throwing: aLoadedDie
		                    using: aFiniteDeck.


	self assert: (anOustandingGame deckOf: 'Delorean') size equals: 2.
	self assert: (anOustandingGame deckOf: 'Enterprise') size equals: 2
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testGameWithABoardOfFifteenBoxesALoadedDieAndASpaceshipEndsWithFinalPositionOfSixteen [

	| aBoard aDie anOutstandingGame aCardDistribution aFiniteDeck |
	aBoard := Board
		          of: 15
		          and: (ParsecUnit of: 15)
		          playedFor: 1
		          with: { (Box with: NoEffect new) }.
	aDie := LoadedDie with: 5.

	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: (OverloadCard)).
	aFiniteDeck := FiniteDeck of: 100 with: aCardDistribution.
	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedBy: 'Enterprise'
		                     on: aBoard
		                     throwing: aDie
		                     using: aFiniteDeck.

	anOutstandingGame startSimulation.

	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 16
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testGameWithAFiniteBoardASequenceLoadedDieAndThreeShipsIsWonAfterThreeLapsAndPlayersHaveSpecificPositions [

	| aBoard aDie aCardDistribution anOutstandingGame aFiniteDeck |
	aBoard := Board
		          of: 10
		          and: (ParsecUnit of: 10)
		          playedFor: 3
		          with: { (Box with: NoEffect new) }.
	aDie := LoadedDie withSequence: { 1. 4. 3 }.

	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: OverloadCard).
	aFiniteDeck := FiniteDeck of: 100 with: aCardDistribution.
	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany:
		                     { 'Zathura'. 'Enterprise'. 'Delorean' }
		                     on: aBoard
		                     throwing: aDie
		                     using: aFiniteDeck.

	anOutstandingGame startSimulation.

	self assert: (aBoard boxPositionOf: 'Zathura') equals: 9.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 11.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 1
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testGameWithAFiniteBoardASequenceLoadedDieAndThreeShipsIsWonAndPlayersHaveSpecificPositions [

	| aBoard aDie aCardDistribution anOutstandingGame aFiniteDeck |
	aBoard := Board
		          of: 10
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          with: { (Box with: NoEffect new) }.
	aDie := LoadedDie withSequence: { 1. 4. 3 }.

	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: OverloadCard).
	aFiniteDeck := FiniteDeck of: 100 with: aCardDistribution.
	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany:
		                     { 'Enterprise'. 'Delorean'. 'Zathura' }
		                     on: aBoard
		                     throwing: aDie
		                     using: aFiniteDeck.

	anOutstandingGame startSimulation.

	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 3.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 11.
	self assert: (aBoard boxPositionOf: 'Zathura') equals: 6
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testGameWithASpaceshipABoardWithFiveBoxesAndALoadedDieWithFourDoesNotEndAfterOneRoll [

	| aBoard aDie aCardDistribution anOutstandingGame aFiniteDeck |
	aBoard := Board
		          of: 5
		          and: (ParsecUnit of: 5)
		          playedFor: 1
		          with: { (Box with: NoEffect new) }.
	aDie := LoadedDie with: 4.

	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: OverloadCard).
	aFiniteDeck := FiniteDeck of: 100 with: aCardDistribution.
	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedBy: 'Enterprise'
		                     on: aBoard
		                     throwing: aDie
		                     using: aFiniteDeck.
	anOutstandingGame play.

	self deny: anOutstandingGame thereIsAWinner
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testGameWithASpaceshipAndABoardEndsWhenItCompletesThreeLaps [

	| aBoard aDie aCardDistribution anOutstandingGame aFiniteDeck |
	aBoard := Board
		          of: 15
		          and: (ParsecUnit of: 15)
		          playedFor: 3
		          with: { (Box with: NoEffect new) }.
	aDie := LoadedDie with: 5.

	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: OverloadCard).
	aFiniteDeck := FiniteDeck of: 100 with: aCardDistribution.
	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedBy: 'Enterprise'
		                     on: aBoard
		                     throwing: aDie
		                     using: aFiniteDeck.

	anOutstandingGame startSimulation.

	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 16.
	self assert: (aBoard lapOf: 'Enterprise') equals: 3
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testGameWithSpaceshipsAFiniteBoardAndADiceCupEnds [

	| aBoard aDie anotherDie otherDie aDiceCup aCardDistribution anOutstandingGame aFiniteDeck |
	aBoard := Board
		          of: 50
		          and: (ParsecUnit of: 50)
		          playedFor: 3
		          with: { (Box with: NoEffect new) }.

	aDie := Die with: 4.
	anotherDie := Die with: 5.
	otherDie := Die with: 6.
	aDiceCup := DiceCup withAll: { 
			            aDie.
			            anotherDie.
			            otherDie }.

	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: OverloadCard).
	aFiniteDeck := FiniteDeck of: 100 with: aCardDistribution.
	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Delorean'. 'Enterprise' }
		                     on: aBoard
		                     throwing: aDiceCup
		                     using: aFiniteDeck.

	anOutstandingGame startSimulation.

	self assert: anOutstandingGame thereIsAWinner
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testGameWithSpaceshipsAFiniteBoardAndADieEnds [

	| aBoard aDie aCardDistribution anOutstandingGame aFiniteDeck |
	aBoard := Board
		          of: 15
		          and: (ParsecUnit of: 15)
		          playedFor: 2
		          with: { (Box with: NoEffect new) }.
	aDie := Die with: 4.
	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: OverloadCard).
	aFiniteDeck := FiniteDeck of: 100 with: aCardDistribution.
	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Zathura'. 'Delorean' }
		                     on: aBoard
		                     throwing: aDie
		                     using: aFiniteDeck.

	anOutstandingGame startSimulation.

	self assert: anOutstandingGame thereIsAWinner
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testGameWithSpaceshipsAFiniteBoardAndALoadedDieEnds [

	| aBoard aLoadedDie aCardDistribution anOutstandingGame aFiniteDeck |
	aBoard := Board
		          of: 5
		          and: (ParsecUnit of: 5)
		          playedFor: 1
		          with: { (Box with: NoEffect new) }.
	aLoadedDie := LoadedDie with: 3.
	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: OverloadCard).
	aFiniteDeck := FiniteDeck of: 100 with: aCardDistribution.
	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Enterprise'. 'Zathura' }
		                     on: aBoard
		                     throwing: aLoadedDie
		                     using: aFiniteDeck.

	anOutstandingGame play.
	anOutstandingGame play.
	anOutstandingGame play.

	self assert: anOutstandingGame thereIsAWinner
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testGameWithSpaceshipsAFiniteBoardAndASequencedLoadedDieHasTheSecondPlayerAsTheWinner [

	| aBoard aLoadedDie aCardDistribution anOutstandingGame aFiniteDeck |
	aBoard := Board
		          of: 15
		          and: (ParsecUnit of: 15)
		          playedFor: 2
		          with: { (Box with: NoEffect new) }.
	aLoadedDie := LoadedDie withSequence: { 1. 3 }.
	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: OverloadCard).
	aFiniteDeck := FiniteDeck of: 100 with: aCardDistribution.
	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Enterprise'. 'Zathura' }
		                     on: aBoard
		                     throwing: aLoadedDie
		                     using: aFiniteDeck.

	anOutstandingGame startSimulation.

	self assert: anOutstandingGame winner equals: 'Zathura'
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testGameWithSpaceshipsAFiniteBoardAndLoadedDieHasBothSpaceshipsPositionChangeUntilItEnds [

	| aBoard aLoadedDie aCardDistribution anOutstandingGame aFiniteDeck |
	aBoard := Board
		          of: 15
		          and: (ParsecUnit of: 15)
		          playedFor: 1
		          with: { (Box with: NoEffect new) }.
	aLoadedDie := LoadedDie with: 4.
	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: OverloadCard).
	aFiniteDeck := FiniteDeck of: 100 with: aCardDistribution.
	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Zathura'. 'Enterprise' }
		                     on: aBoard
		                     throwing: aLoadedDie
		                     using: aFiniteDeck.

	anOutstandingGame startSimulation.

	self assert: (aBoard boxPositionOf: 'Zathura') equals: 16.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 12
]

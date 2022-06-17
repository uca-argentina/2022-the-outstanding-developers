Class {
	#name : #CardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
CardTest >> should: block raise: expectedErrorClass withMessage: expectedErrorMessage [

	self
		should: block
		raise: expectedErrorClass
		whoseDescriptionIncludes: expectedErrorMessage
		description: 'Test did not failed as expected'
]

{ #category : #tests }
CardTest >> testACardIsNotTakenAwayFromASpaceshipWhenThrownButNotItsTurn [

	| overloadCard aBoard collectionOfCards aCardDistribution anOutstandingGame |
	overloadCard := OverloadCard asA: PermanentCard new.
	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: (OverloadCard behavingAsA: PermanentCard)).
	aBoard := Board
		          of: 10
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          with: { (Box with: NoEffect new) }.
	
	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany:
		                     { 'Delorean'. 'Enterprise' }
		                     on: aBoard
		                     throwing:
		                     (LoadedDie withSequence: { 7. 6. 5. 6 })
		                     using: aCardDistribution.
	anOutstandingGame play.
	
	self
		should: [ anOutstandingGame throws: (OverloadCard thrownAt: 'Enterprise' asA: PermanentCard) from: 'Delorean' ]
		raise: Error
		withMessage: 'Permanent cards can only be thrown in spaceships turn'.

	self
		assert: (anOutstandingGame deckOf: 'Enterprise') size
		equals: 2
]

{ #category : #tests }
CardTest >> testACardIsTakenAwayFromASpaceshipWhenThrown [

	| enterprise aBoard aCardDistribution anOutstandingGame |
	aBoard := Board
		          of: 10
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          with: { (Box with: NoEffect new) }.
	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: (OverloadCard behavingAsA: PermanentCard)).
	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Enterprise'. 'Delorean' }
		                     on: aBoard
		                     throwing: (LoadedDie with: 1)
		                     using: aCardDistribution.
	self assert: (anOutstandingGame deckOf: 'Enterprise') size equals: 2.

	anOutstandingGame
		throws: (OverloadCard thrownAt: 'Delorean' asA: PermanentCard)
		from: 'Enterprise'.

	self assert: (anOutstandingGame deckOf: 'Enterprise') size equals: 1
]

{ #category : #tests }
CardTest >> testASpaceshipCannotThrowACardItDoesntHave [

	| aBoard aCardDistribution anOutstandingGame |
	aBoard := Board
		          of: 10
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          with: { (Box with: NoEffect new) }.
	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: (OverloadCard behavingAsA: PermanentCard)).
	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Delorean'. 'Enterprise' }
		                     on: aBoard
		                     throwing:
		                     (LoadedDie with: 1)
		                     using: aCardDistribution.

	self
		should: [ anOutstandingGame throws: (SpeedCard thrownAt: 'Enterprise' asA: PermanentCard) from: 'Delorean' ]
		raise: Error
		withMessage: 'The spaceship doesnt have cards to throw'
]

{ #category : #tests }
CardTest >> testAccelerationCardIncreasesInOneAllTheSpaceshipsDiceThrows [

	| aBoard aCardDistribution anOutstandingGame |

	aBoard := Board
		          of: 10
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          with: { (Box with: NoEffect new) }.
		
	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: (AccelerationCard behavingAsA: PermanentCard)).
	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Enterprise'. 'Delorean'. 'Zathura' }
		                     on: aBoard
		                     throwing:
		                     (LoadedDie withSequence: {3. 4. 5. 2. 2. 2 })
		                     using: aCardDistribution.	
	
	anOutstandingGame throws: (AccelerationCard behavingAsA: PermanentCard) from: 'Enterprise'.

	anOutstandingGame play.
	anOutstandingGame play.
	anOutstandingGame play.

	self assert: (aBoard positionOf: 'Enterprise') equals: 4.
	self assert: (aBoard positionOf: 'Delorean') equals: 5.
	self assert: (aBoard positionOf: 'Zathura') equals: 6.

	anOutstandingGame play.
	anOutstandingGame play.
	anOutstandingGame play.

	self assert: (aBoard positionOf: 'Enterprise') equals: 7.
	self assert: (aBoard positionOf: 'Delorean') equals: 8.
	self assert: (aBoard positionOf: 'Zathura') equals: 9
]

{ #category : #tests }
CardTest >> testAnInstantaneousCardCanOnlyBeUsedOnce [

	| overloadCard aBoard delorean enterprise |
	overloadCard := OverloadCard asA: InstantaneousCard new.
	delorean := Spaceship called: 'Delorean'.
	enterprise := Spaceship called: 'Enterprise'.
	delorean receives: overloadCard.

	aBoard := Board
		          of: 10
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          byMany: { 
				          delorean.
				          enterprise }
		          with: { (Box with: NoEffect new) }.

	delorean throw: 1 to: 'Enterprise' in: aBoard.
	"self halt."
	self
		should: [ delorean throw: 1 to: 'Enterprise' in: aBoard ]
		raise: Error
		withMessage: 'No se, algun error'
]

{ #category : #tests }
CardTest >> testAnInstantaneousCardCantBeUsedIfTheGameHasFinished [

	| overloadCard enterprise aBoard delorean |
	overloadCard := OverloadCard asA: InstantaneousCard new.
	enterprise := Spaceship called: 'Enterprise'.
	delorean := Spaceship called: 'Delorean'.
	delorean receives: overloadCard.

	aBoard := Board
		          of: 10
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          byMany: { 
				          enterprise.
				          delorean }
		          with: { (Box with: NoEffect new) }.

	aBoard moveSpaceship: 3.
	aBoard moveSpaceship: 2.
	aBoard moveSpaceship: 8.

	self
		should: [ delorean throw: 1 to: 'Enterprise' in: aBoard ]
		raise: Error
		withMessage: 'Cards can only be thrown if game has not finished'
]

{ #category : #tests }
CardTest >> testCancellationCardCantBePlayedIfTheChosenCardisNotInGame [

	| aBoard aCardDistribution anotherCardDistribution cardAwarderEffect box1 box2 box3 box4 box5 anOutstandingGame |
	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: (OverloadCard behavingAsA: PermanentCard)).
	anotherCardDistribution := OrderedCollection new.
	anotherCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: (CancellationCard behavingAsA: InstantaneousCard)).
	cardAwarderEffect := CardAwarderEffect with: anotherCardDistribution.

	box1 := Box with: cardAwarderEffect.
	box2 := Box with: NoEffect new.
	box3 := Box with: NoEffect new.
	box4 := Box with: NoEffect new.
	box5 := Box with: NoEffect new.

	aBoard := Board
		          of: 10
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          with: { 
				          box1.
				          box2.
				          box3.
				          box4.
				          box5 }.

	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Enterprise'. 'Delorean' }
		                     on: aBoard
		                     throwing:
		                     (LoadedDie withSequence: { 1. 2. 3. 3. 4 })
		                     using: aCardDistribution.
	anOutstandingGame play.
	anOutstandingGame
		throws: (OverloadCard thrownAt: 'Enterprise' asA: PermanentCard)
		from: 'Delorean'.
	anOutstandingGame play.
	self
		should: [ 
			anOutstandingGame
				throws: (CancellationCard
						 thrownAt: 'Speed'
						 affecting: 'Delorean'
						 asA: InstantaneousCard)
				from: 'Enterprise' ]
		raise: Error
		withMessage:
		'Cancellation card cant be used if the chosen card is not in game'
]

{ #category : #tests }
CardTest >> testCancellationCardCantBePlayedIfThereAreNoPermanentCardsInGame [

	| aBoard aCardDistribution anOutstandingGame |
	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: (CancellationCard behavingAsA: InstantaneousCard)).

	aBoard := Board
		          of: 10
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          with: { (Box with: NoEffect new) }.

	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Enterprise'. 'Delorean' }
		                     on: aBoard
		                     throwing: (LoadedDie with: 1)
		                     using: aCardDistribution.

	self
		should: [ 
			anOutstandingGame
				throws: (CancellationCard
						 thrownAt: 'Overload'
						 affecting: 'Delorean'
						 asA: InstantaneousCard)
				from: 'Enterprise' ]
		raise: Error
		withMessage:
		'Cancellation card cant be used if there are no Permanet Cards in game'
]

{ #category : #tests }
CardTest >> testCancellationCardRemovesAPermanentCard [

	| aBoard aCardDistribution anotherCardDistribution cardAwarderEffect box1 box2 box3 box4 box5 anOutstandingGame |
	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: (OverloadCard behavingAsA: PermanentCard)).
	anotherCardDistribution := OrderedCollection new.
	anotherCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: (CancellationCard behavingAsA: InstantaneousCard)).
	cardAwarderEffect := CardAwarderEffect with: anotherCardDistribution.

	box1 := Box with: cardAwarderEffect.
	box2 := Box with: NoEffect new.
	box3 := Box with: NoEffect new.
	box4 := Box with: NoEffect new.
	box5 := Box with: NoEffect new.

	aBoard := Board
		          of: 10
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          with: { 
				          box1.
				          box2.
				          box3.
				          box4.
				          box5 }.

	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Enterprise'. 'Delorean' }
		                     on: aBoard
		                     throwing:
		                     (LoadedDie withSequence: { 1. 2. 3. 3. 4 })
		                     using: aCardDistribution.
	anOutstandingGame play.
	anOutstandingGame
		throws: (OverloadCard thrownAt: 'Enterprise' asA: PermanentCard)
		from: 'Delorean'.
	anOutstandingGame play.

	self assert: (aBoard positionOf: 'Enterprise') equals: 1.
	self assert: (aBoard lapOf: 'Enterprise') equals: 1.
	self assert: (aBoard positionOf: 'Delorean') equals: 2.
	self assert: (aBoard lapOf: 'Delorean') equals: 1.

	anOutstandingGame play.
	anOutstandingGame play.

	self assert: (aBoard positionOf: 'Enterprise') equals: 2.
	self assert: (aBoard lapOf: 'Enterprise') equals: 1.
	self assert: (aBoard positionOf: 'Delorean') equals: 5.
	self assert: (aBoard lapOf: 'Delorean') equals: 1.
	
	anOutstandingGame
		throws: (CancellationCard
				 thrownAt: 'Overload'
				 affecting: 'Enterprise'
				 asA: InstantaneousCard)
		from: 'Enterprise'.
	anOutstandingGame play.
	anOutstandingGame play.
	
	self assert: (aBoard positionOf: 'Enterprise') equals: 6.
	self assert: (aBoard lapOf: 'Enterprise') equals: 1.
	self assert: (aBoard positionOf: 'Delorean') equals: 6.
	self assert: (aBoard lapOf: 'Delorean') equals: 1
]

{ #category : #tests }
CardTest >> testEffectOfMultipleSpeedCardsIsAddedUpIntoTheSpaceshipDiceThrow [

	| aBoard aCardDistribution anOutstandingGame |

	aBoard := Board
		          of: 10
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          with: { (Box with: NoEffect new) }.
	
	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: (SpeedCard behavingAsA: PermanentCard)).
	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Enterprise'. 'Delorean'}
		                     on: aBoard
		                     throwing:
		                     (LoadedDie with: 1)
		                     using: aCardDistribution.	
	
	anOutstandingGame throws: (SpeedCard thrownAt: 'Delorean' asA: PermanentCard) from: 'Enterprise'.
	anOutstandingGame throws: (SpeedCard thrownAt: 'Delorean' asA: PermanentCard) from: 'Enterprise'.
	anOutstandingGame play.
	anOutstandingGame play.

	self assert: (aBoard positionOf: 'Enterprise') equals: 1.
	self assert: (aBoard positionOf: 'Delorean') equals: 3
]

{ #category : #tests }
CardTest >> testOverloadCardProducesSpaceshipToGoBackwards [

	"Cual es el sentido de este si está el de ReducesInTwo?"

	| aBoard aCardDistribution anOutstandingGame |
	aBoard := Board
		          of: 10
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          with: { (Box with: NoEffect new) }.

	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: (OverloadCard behavingAsA: PermanentCard)).
	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Enterprise'. 'Delorean' }
		                     on: aBoard
		                     throwing:
		                     (LoadedDie withSequence: { 3. 4. 2. 1 })
		                     using: aCardDistribution.
	anOutstandingGame play.
	anOutstandingGame play.
	
	self assert: (aBoard positionOf: 'Enterprise') equals: 3.
	self assert: (aBoard positionOf: 'Delorean') equals: 4.
	anOutstandingGame throws: (OverloadCard thrownAt: 'Delorean' asA: PermanentCard) from: 'Enterprise'. 

	anOutstandingGame play.
	anOutstandingGame play.

	self assert: (aBoard positionOf: 'Enterprise') equals: 5.
	self assert: (aBoard positionOf: 'Delorean') equals: 3
]

{ #category : #tests }
CardTest >> testOverloadCardReducesInTwoTheSpaceshipDiceThrow [

	| aBoard aCardDistribution anOutstandingGame |
	aBoard := Board
		          of: 10
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          with: { (Box with: NoEffect new) }.
	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: (OverloadCard behavingAsA: PermanentCard)).
	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Enterprise'. 'Delorean' }
		                     on: aBoard
		                     throwing: (LoadedDie withSequence: { 3. 4 })
		                     using: aCardDistribution.

	anOutstandingGame
		throws: (OverloadCard thrownAt: 'Delorean' asA: PermanentCard)
		from: 'Enterprise'.

	anOutstandingGame play.
	anOutstandingGame play.
	self assert: (aBoard positionOf: 'Enterprise') equals: 3.
	self assert: (aBoard positionOf: 'Delorean') equals: 2
]

{ #category : #tests }
CardTest >> testSpeedCardIncreasesInOneTheSpaceshipDiceThrow [

	| aBoard aCardDistribution anOutstandingGame |
	aBoard := Board
		          of: 10
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          with: { (Box with: NoEffect new) }.
	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: (SpeedCard behavingAsA: PermanentCard)).
	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Delorean'. 'Enterprise' }
		                     on: aBoard
		                     throwing:
		                     (LoadedDie withSequence: { 3. 4 })
		                     using: aCardDistribution.
	anOutstandingGame throws: (SpeedCard thrownAt: 'Enterprise' asA: PermanentCard) from: 'Delorean'.
	anOutstandingGame play.
	anOutstandingGame play.
	self assert: (aBoard positionOf: 'Delorean') equals: 3.
	self assert: (aBoard positionOf: 'Enterprise') equals: 5
]

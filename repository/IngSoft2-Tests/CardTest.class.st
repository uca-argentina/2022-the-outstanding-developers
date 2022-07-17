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

	| aBoard aCardDistribution anOutstandingGame aFiniteDeck |
	aCardDistribution := OrderedCollection new.
	aCardDistribution add:
		(Distribution withProbabilityOf: 1 for: OverloadCard).
	aFiniteDeck := FiniteDeck of: 100 with: aCardDistribution.
	aBoard := Board
		          of: 10
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          with: { (Box with: NoEffect new) }.

	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Delorean'. 'Enterprise' }
		                     on: aBoard
		                     throwing:
		                     (LoadedDie withSequence: { 7. 6. 5. 6 })
		                     using: aFiniteDeck.
	anOutstandingGame play.

	self
		should: [ 
			anOutstandingGame
				throws: (OverloadCard thrownAt: 'Enterprise')
				from: 'Delorean' ]
		raise: Error
		withMessage: 'Permanent cards can only be thrown in spaceships turn'.

	self assert: (anOutstandingGame deckOf: 'Enterprise') size equals: 2
]

{ #category : #tests }
CardTest >> testACardIsTakenAwayFromASpaceshipWhenThrown [

	| aBoard aCardDistribution anOutstandingGame aFiniteDeck |
	aBoard := Board
		          of: 10
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          with: { (Box with: NoEffect new) }.
	aCardDistribution := OrderedCollection new.
	aCardDistribution add:
		(Distribution withProbabilityOf: 1 for: OverloadCard).
	aFiniteDeck := FiniteDeck of: 100 with: aCardDistribution.
	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Enterprise'. 'Delorean' }
		                     on: aBoard
		                     throwing: (LoadedDie with: 1)
		                     using: aFiniteDeck.
	self assert: (anOutstandingGame deckOf: 'Enterprise') size equals: 2.

	anOutstandingGame
		throws: (OverloadCard thrownAt: 'Delorean')
		from: 'Enterprise'.

	self assert: (anOutstandingGame deckOf: 'Enterprise') size equals: 1
]

{ #category : #tests }
CardTest >> testASpaceshipCannotThrowACardItDoesntHave [

	| aBoard aCardDistribution anOutstandingGame aFiniteDeck |
	aBoard := Board
		          of: 10
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          with: { (Box with: NoEffect new) }.
	aCardDistribution := OrderedCollection new.
	aCardDistribution add:
		(Distribution withProbabilityOf: 1 for: OverloadCard).
	aFiniteDeck := FiniteDeck of: 100 with: aCardDistribution.
	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Delorean'. 'Enterprise' }
		                     on: aBoard
		                     throwing: (LoadedDie with: 1)
		                     using: aFiniteDeck.

	self
		should: [ 
			anOutstandingGame
				throws: (SpeedCard thrownAt: 'Enterprise')
				from: 'Delorean' ]
		raise: Error
		withMessage: 'The spaceship doesnt have cards to throw'
]

{ #category : #tests }
CardTest >> testAccelerationCardIncreasesInOneAllTheSpaceshipsDiceThrows [

	| aBoard aCardDistribution anOutstandingGame aFiniteDeck |
	aBoard := Board
		          of: 10
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          with: { (Box with: NoEffect new) }.

	aCardDistribution := OrderedCollection new.
	aCardDistribution add:
		(Distribution withProbabilityOf: 1 for: AccelerationCard).
	aFiniteDeck := FiniteDeck of: 100 with: aCardDistribution.
	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany:
		                     { 'Enterprise'. 'Delorean'. 'Zathura' }
		                     on: aBoard
		                     throwing:
		                     (LoadedDie withSequence: { 3. 4. 5. 2. 2. 2 })
		                     using: aFiniteDeck.

	anOutstandingGame throws: AccelerationCard from: 'Enterprise'.

	anOutstandingGame play.
	anOutstandingGame play.
	anOutstandingGame play.

	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 4.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 5.
	self assert: (aBoard boxPositionOf: 'Zathura') equals: 6.

	anOutstandingGame play.
	anOutstandingGame play.
	anOutstandingGame play.

	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 7.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 8.
	self assert: (aBoard boxPositionOf: 'Zathura') equals: 9
]

{ #category : #tests }
CardTest >> testAnInstantaneousCardCantBeUsedIfTheGameHasFinished [

	| aBoard cardAwarderEffect box1 box2 box3 box4 box5 anOutstandingGame aFiniteDeck |
	aFiniteDeck := FiniteDeck of: 10 setWith: { 
			               OverloadCard create.
			               OverloadCard create.
			               OverloadCard create.
			               OverloadCard create.
			               CancellationCard create.
			               CancellationCard create }.
	cardAwarderEffect := CardAwarderEffect associatedTo: aFiniteDeck.

	box1 := Box with: cardAwarderEffect.
	box2 := Box with: cardAwarderEffect.
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
		                     (LoadedDie withSequence:
			                      { 1. 1. 1. 1. 1. 1. 8 })
		                     using: aFiniteDeck.

	anOutstandingGame play.
	anOutstandingGame
		throws: (OverloadCard thrownAt: 'Enterprise')
		from: 'Delorean'.
	anOutstandingGame play.
	anOutstandingGame
		throws:
		(CancellationCard thrownAt: (OverloadCard thrownAt: 'Enterprise'))
		from: 'Enterprise'.
	anOutstandingGame play.
	anOutstandingGame play.
	anOutstandingGame play.
	anOutstandingGame play.
	anOutstandingGame play.
	self
		should: [ 
			anOutstandingGame
				throws:
				(CancellationCard thrownAt: (OverloadCard thrownAt: 'Enterprise'))
				from: 'Delorean' ]
		raise: Error
		withMessage: 'Cards can only be thrown if game has not finished'
]

{ #category : #tests }
CardTest >> testAnInstantaneousCardEffectAffectOnlyOnce [

	| aBoard cardAwarderEffect box1 box2 box3 box4 box5 anOutstandingGame aFiniteDeck |
	aFiniteDeck := FiniteDeck of: 10 setWith: { 
			               OverloadCard create.
			               OverloadCard create.
			               OverloadCard create.
			               OverloadCard create.
			               CancellationCard create.
			               CancellationCard create }.
	cardAwarderEffect := CardAwarderEffect associatedTo: aFiniteDeck.

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
		                     using: aFiniteDeck.
	anOutstandingGame play.
	anOutstandingGame
		throws: (OverloadCard thrownAt: 'Enterprise')
		from: 'Delorean'.
	anOutstandingGame
		throws: (OverloadCard thrownAt: 'Enterprise')
		from: 'Delorean'.
	anOutstandingGame play.

	self
		assert: (anOutstandingGame cardsAffectingOf: 'Enterprise') size
		equals: 2.

	anOutstandingGame
		throws:
		(CancellationCard thrownAt: (OverloadCard thrownAt: 'Enterprise'))
		from: 'Enterprise'.

	self
		assert: (anOutstandingGame cardsAffectingOf: 'Enterprise') size
		equals: 1
]

{ #category : #tests }
CardTest >> testCancellationCardCantBePlayedIfTheChosenCardisNotInGame [

	| aBoard cardAwarderEffect box1 box2 box3 box4 box5 anOutstandingGame aFiniteDeck |
	aFiniteDeck := FiniteDeck of: 10 setWith: { 
			               OverloadCard create.
			               OverloadCard create.
			               OverloadCard create.
			               OverloadCard create.
			               CancellationCard create.
			               CancellationCard create }.
	cardAwarderEffect := CardAwarderEffect associatedTo: aFiniteDeck.

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
		                     using: aFiniteDeck.
	anOutstandingGame play.
	anOutstandingGame
		throws: (OverloadCard thrownAt: 'Enterprise')
		from: 'Delorean'.
	anOutstandingGame play.
	self
		should: [ 
			anOutstandingGame
				throws:
				(CancellationCard thrownAt: (SpeedCard thrownAt: 'Delorean'))
				from: 'Enterprise' ]
		raise: Error
		withMessage:
		'Cancellation card cant be used if the chosen card is not in game'
]

{ #category : #tests }
CardTest >> testCancellationCardCantBePlayedIfThereAreNoPermanentCardsInGame [

	| aBoard aCardDistribution anOutstandingGame aFiniteDeck |
	aCardDistribution := OrderedCollection new.
	aCardDistribution add:
		(Distribution withProbabilityOf: 1 for: CancellationCard).
	aFiniteDeck := FiniteDeck of: 100 with: aCardDistribution.
	aBoard := Board
		          of: 10
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          with: { (Box with: NoEffect new) }.

	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Enterprise'. 'Delorean' }
		                     on: aBoard
		                     throwing: (LoadedDie with: 1)
		                     using: aFiniteDeck.

	self
		should: [ 
			anOutstandingGame
				throws: (CancellationCard thrownAt: 'Overload')
				from: 'Enterprise' ]
		raise: Error
		withMessage:
		'Cancellation card cant be used if there are no Permanet Cards in game'
]

{ #category : #tests }
CardTest >> testCancellationCardRemovesASpeedPermanentCard [

	| aBoard cardAwarderEffect box1 box2 box3 box4 box5 anOutstandingGame aFiniteDeck |
	aFiniteDeck := FiniteDeck of: 10 setWith: { 
			               SpeedCard create.
			               SpeedCard create.
			               SpeedCard create.
			               SpeedCard create.
			               CancellationCard create.
			               CancellationCard create }.
	cardAwarderEffect := CardAwarderEffect associatedTo: aFiniteDeck.

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
		                     using: aFiniteDeck.
	anOutstandingGame play.

	anOutstandingGame
		throws: (SpeedCard thrownAt: 'Enterprise')
		from: 'Delorean'.
	anOutstandingGame play.

	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 1.
	self assert: (aBoard lapOf: 'Enterprise') equals: 1.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 2.
	self assert: (aBoard lapOf: 'Delorean') equals: 1.

	anOutstandingGame play.
	anOutstandingGame play.

	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 5.
	self assert: (aBoard lapOf: 'Enterprise') equals: 1.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 5.
	self assert: (aBoard lapOf: 'Delorean') equals: 1.

	anOutstandingGame
		throws: (CancellationCard
				 thrownAt: (SpeedCard thrownAt: 'Enterprise')
				 )
		from: 'Enterprise'.
	anOutstandingGame play.
	anOutstandingGame play.

	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 9.
	self assert: (aBoard lapOf: 'Enterprise') equals: 1.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 6.
	self assert: (aBoard lapOf: 'Delorean') equals: 1
]

{ #category : #tests }
CardTest >> testCancellationCardRemovesAnAccelerationPermanentCard [

	| aBoard cardAwarderEffect box1 box2 box3 box4 box5 anOutstandingGame aFiniteDeck |
	aFiniteDeck := FiniteDeck of: 10 setWith: { 
			               AccelerationCard create.
			               AccelerationCard create.
			               AccelerationCard create.
			               AccelerationCard create.
			               CancellationCard create.
			               CancellationCard create }.
	cardAwarderEffect := CardAwarderEffect associatedTo: aFiniteDeck.

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
		                     using: aFiniteDeck.
	anOutstandingGame play.
	anOutstandingGame throws: AccelerationCard from: 'Delorean'.
	anOutstandingGame play.

	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 1.
	self assert: (aBoard lapOf: 'Enterprise') equals: 1.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 3.
	self assert: (aBoard lapOf: 'Delorean') equals: 1.

	anOutstandingGame play.
	anOutstandingGame play.

	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 5.
	self assert: (aBoard lapOf: 'Enterprise') equals: 1.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 7.
	self assert: (aBoard lapOf: 'Delorean') equals: 1.

	anOutstandingGame
		throws: (CancellationCard thrownAt: AccelerationCard)
		from: 'Enterprise'.
	anOutstandingGame play.
	anOutstandingGame play.

	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 9.
	self assert: (aBoard lapOf: 'Enterprise') equals: 1.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 8.
	self assert: (aBoard lapOf: 'Delorean') equals: 1
]

{ #category : #tests }
CardTest >> testCancellationCardRemovesAnOverloadPermanentCard [

	| aBoard cardAwarderEffect box1 box2 box3 box4 box5 anOutstandingGame aFiniteDeck |
	aFiniteDeck := FiniteDeck of: 10 setWith: { 
			               OverloadCard create.
			               OverloadCard create.
			               OverloadCard create.
			               OverloadCard create.
			               CancellationCard create.
			               CancellationCard create }.
	cardAwarderEffect := CardAwarderEffect associatedTo: aFiniteDeck.

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
		                     using: aFiniteDeck .
	anOutstandingGame play.
	anOutstandingGame
		throws: (OverloadCard thrownAt: 'Enterprise')
		from: 'Delorean'.
	anOutstandingGame play.

	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 1.
	self assert: (aBoard lapOf: 'Enterprise') equals: 1.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 2.
	self assert: (aBoard lapOf: 'Delorean') equals: 1.

	anOutstandingGame play.
	anOutstandingGame play.

	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 2.
	self assert: (aBoard lapOf: 'Enterprise') equals: 1.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 5.
	self assert: (aBoard lapOf: 'Delorean') equals: 1.

	anOutstandingGame
		throws: (CancellationCard
				 thrownAt: (OverloadCard thrownAt: 'Enterprise')
				 )
		from: 'Enterprise'.
	anOutstandingGame play.
	anOutstandingGame play.

	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 6.
	self assert: (aBoard lapOf: 'Enterprise') equals: 1.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 6.
	self assert: (aBoard lapOf: 'Delorean') equals: 1
]

{ #category : #tests }
CardTest >> testCancellationCardRemovesOnlyOneAccelerationPermanentCard [

	| aBoard cardAwarderEffect box1 box2 box3 box4 box5 anOutstandingGame aFiniteDeck |
	aFiniteDeck := FiniteDeck of: 10 setWith: { 
			               AccelerationCard create.
			               AccelerationCard create.
			               AccelerationCard create.
			               AccelerationCard create.
			               CancellationCard create.
			               CancellationCard create }.
	cardAwarderEffect := CardAwarderEffect associatedTo: aFiniteDeck.

	box1 := Box with: cardAwarderEffect.
	box2 := Box with: NoEffect new.
	box3 := Box with: NoEffect new.
	box4 := Box with: NoEffect new.
	box5 := Box with: NoEffect new.

	aBoard := Board
		          of: 20
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
		                     using: aFiniteDeck.
	anOutstandingGame play.
	anOutstandingGame throws: AccelerationCard from: 'Delorean'.
	anOutstandingGame throws: AccelerationCard from: 'Delorean'.
	anOutstandingGame play.

	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 1.
	self assert: (aBoard lapOf: 'Enterprise') equals: 1.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 4.
	self assert: (aBoard lapOf: 'Delorean') equals: 1.

	anOutstandingGame play.
	anOutstandingGame play.

	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 6.
	self assert: (aBoard lapOf: 'Enterprise') equals: 1.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 9.
	self assert: (aBoard lapOf: 'Delorean') equals: 1.

	anOutstandingGame
		throws: (CancellationCard thrownAt: AccelerationCard)
		from: 'Enterprise'.
	anOutstandingGame play.
	anOutstandingGame play.

	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 11.
	self assert: (aBoard lapOf: 'Enterprise') equals: 1.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 11.
	self assert: (aBoard lapOf: 'Delorean') equals: 1
]

{ #category : #tests }
CardTest >> testEffectOfMultipleSpeedCardsIsAddedUpIntoTheSpaceshipDiceThrow [

	| aBoard aCardDistribution anOutstandingGame aFiniteDeck |
	aBoard := Board
		          of: 10
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          with: { (Box with: NoEffect new) }.

	aCardDistribution := OrderedCollection new.
	aCardDistribution add:
		(Distribution withProbabilityOf: 1 for: SpeedCard).
	aFiniteDeck := FiniteDeck of: 100 with: aCardDistribution.
	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Enterprise'. 'Delorean' }
		                     on: aBoard
		                     throwing: (LoadedDie with: 1)
		                     using: aFiniteDeck.

	anOutstandingGame
		throws: (SpeedCard thrownAt: 'Delorean')
		from: 'Enterprise'.
	anOutstandingGame
		throws: (SpeedCard thrownAt: 'Delorean')
		from: 'Enterprise'.
	anOutstandingGame play.
	anOutstandingGame play.

	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 1.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 3
]

{ #category : #tests }
CardTest >> testOverloadCardProducesSpaceshipToGoBackwards [

	| aBoard aCardDistribution anOutstandingGame aFiniteDeck |
	aBoard := Board
		          of: 10
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          with: { (Box with: NoEffect new) }.

	aCardDistribution := OrderedCollection new.
	aCardDistribution add:
		(Distribution withProbabilityOf: 1 for: OverloadCard).
	aFiniteDeck := FiniteDeck of: 100 with: aCardDistribution.
	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Enterprise'. 'Delorean' }
		                     on: aBoard
		                     throwing:
		                     (LoadedDie withSequence: { 3. 4. 2. 1 })
		                     using: aFiniteDeck.
	anOutstandingGame play.
	anOutstandingGame play.

	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 3.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 4.
	anOutstandingGame
		throws: (OverloadCard thrownAt: 'Delorean')
		from: 'Enterprise'.

	anOutstandingGame play.
	anOutstandingGame play.

	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 5.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 3
]

{ #category : #tests }
CardTest >> testOverloadCardReducesInTwoTheSpaceshipDiceThrow [

	| aBoard aCardDistribution anOutstandingGame aFiniteDeck |
	aBoard := Board
		          of: 10
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          with: { (Box with: NoEffect new) }.
	aCardDistribution := OrderedCollection new.
	aCardDistribution add:
		(Distribution withProbabilityOf: 1 for: OverloadCard).
	aFiniteDeck := FiniteDeck of: 100 with: aCardDistribution.
	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Enterprise'. 'Delorean' }
		                     on: aBoard
		                     throwing: (LoadedDie withSequence: { 3. 4 })
		                     using: aFiniteDeck.

	anOutstandingGame
		throws: (OverloadCard thrownAt: 'Delorean')
		from: 'Enterprise'.

	anOutstandingGame play.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 3.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 2
]

{ #category : #tests }
CardTest >> testRedoCantBePlayedIfNoCardHasBeenPlayedBefore [

	| aCardDistribution cardAwarderEffect box1 box2 box3 box4 box5 aBoard anOutstandingGame aFiniteDeck |
	aCardDistribution := OrderedCollection new.
	aCardDistribution add:
		(Distribution withProbabilityOf: 1 for: RedoCard).
	aFiniteDeck := FiniteDeck of: 100 with: aCardDistribution.
	cardAwarderEffect := CardAwarderEffect associatedTo: aFiniteDeck.

	box1 := Box with: cardAwarderEffect.
	box2 := Box with: cardAwarderEffect.
	box3 := Box with: cardAwarderEffect.
	box4 := Box with: cardAwarderEffect.
	box5 := Box with: cardAwarderEffect.

	aBoard := Board
		          of: 20
		          and: (ParsecUnit of: 20)
		          playedFor: 1
		          with: { 
				          box1.
				          box2.
				          box3.
				          box4.
				          box5 }.

	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedBy: 'Enterprise'
		                     on: aBoard
		                     throwing: (LoadedDie with: 1)
		                     using: aFiniteDeck.

	self
		should: [ 
			anOutstandingGame
				throws: (RedoCard thrownAt: 'Enterprise')
				from: 'Enterprise' ]
		raise: Error
		withMessage: 'No card has been played yet'
]

{ #category : #tests }
CardTest >> testRedoRepeatsAPreviousRedoCard [

	| aBoard aFiniteDeck cardAwarderEffect box1 box2 box3 box4 box5 anOutstandingGame |
	aFiniteDeck := FiniteDeck of: 30 setWith: { 
			               SpeedCard create.
			               SpeedCard create.
			               SpeedCard create.
			               SpeedCard create.
			               RedoCard create.
			               RedoCard create }.
	cardAwarderEffect := CardAwarderEffect associatedTo: aFiniteDeck.
	box1 := Box with: cardAwarderEffect.
	box2 := Box with: cardAwarderEffect.
	box3 := Box with: cardAwarderEffect.
	box4 := Box with: cardAwarderEffect.
	box5 := Box with: cardAwarderEffect.

	aBoard := Board
		          of: 20
		          and: (ParsecUnit of: 20)
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
		                     throwing: (LoadedDie withSequence: { 1. 2 })
		                     using: aFiniteDeck.
	anOutstandingGame play.
	anOutstandingGame
		throws: (SpeedCard thrownAt: 'Enterprise')
		from: 'Delorean'.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 1.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 2.
	anOutstandingGame
		throws: (RedoCard thrownAt: 'Delorean')
		from: 'Enterprise'.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 3.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 5.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 5.
	anOutstandingGame
		throws: (RedoCard thrownAt: 'Enterprise')
		from: 'Delorean'.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 8.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 8.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 11.
	anOutstandingGame
		throws: (RedoCard thrownAt: 'Delorean')
		from: 'Enterprise'.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 11.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 15
]

{ #category : #tests }
CardTest >> testRedoRepeatsARepeatCard [

	| aBoard aFiniteDeck box1 box2 box3 box4 box5 anOutstandingGame cardAwarderRepeatEffect |
	aFiniteDeck := FiniteDeck of: 30 setWith: { 
			               RedoCard create.
			               RedoCard create.
			               RedoCard create.
			               RedoCard create.
			               RepeatCard create.
			               RepeatCard create }.
	cardAwarderRepeatEffect := CardAwarderEffect associatedTo:
		                           aFiniteDeck.

	box1 := Box with: NoEffect new.
	box2 := Box with: cardAwarderRepeatEffect.
	box3 := Box with: SpeedUpEffect new.
	box4 := Box with: NoEffect new.
	box5 := Box with: NoEffect new.

	aBoard := Board
		          of: 20
		          and: (ParsecUnit of: 20)
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
		                     throwing: (LoadedDie withSequence: { 2. 3 })
		                     using: aFiniteDeck.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 2.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 7.

	anOutstandingGame
		throws: (RepeatCard thrownAt: 'Delorean')
		from: 'Enterprise'.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 11.
	anOutstandingGame
		throws: (RedoCard thrownAt: 'Delorean')
		from: 'Enterprise'.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 15
]

{ #category : #tests }
CardTest >> testRedoRepeatsAcceleration [

	| aBoard aFiniteDeck cardAwarderEffect box1 box2 box3 box4 box5 anOutstandingGame |
	aFiniteDeck := FiniteDeck of: 30 setWith: { 
			               AccelerationCard create.
			               AccelerationCard create.
			               AccelerationCard create.
			               AccelerationCard create.
			               RedoCard create.
			               RedoCard create }.
	cardAwarderEffect := CardAwarderEffect associatedTo: aFiniteDeck.

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
		                     throwing: (LoadedDie withSequence: { 1. 2 })
		                     using: aFiniteDeck.
	anOutstandingGame play.
	anOutstandingGame throws: AccelerationCard from: 'Delorean'.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 3.
	anOutstandingGame
		throws: (RedoCard thrownAt: EmptyCard new)
		from: 'Enterprise'.
	anOutstandingGame play.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 7
]

{ #category : #tests }
CardTest >> testRedoRepeatsCancellationOfASpeed [

	| aBoard aFiniteDeck cardAwarderEffect anOutstandingGame |
	aFiniteDeck := FiniteDeck of: 30 setWith: { 
			               SpeedCard create.
			               SpeedCard create.
			               SpeedCard create.
			               SpeedCard create.
			               CancellationCard create.
			               RedoCard create.
			               RedoCard create }.
	cardAwarderEffect := CardAwarderEffect associatedTo: aFiniteDeck.

	aBoard := Board
		          of: 10
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          with: { Box with: cardAwarderEffect }.

	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Enterprise'. 'Delorean' }
		                     on: aBoard
		                     throwing: (LoadedDie withSequence: { 1. 2. 3 })
		                     using: aFiniteDeck.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 1.
	anOutstandingGame
		throws: (SpeedCard thrownAt: 'Enterprise')
		from: 'Delorean'.
	anOutstandingGame
		throws: (SpeedCard thrownAt: 'Enterprise')
		from: 'Delorean'.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 2.
	anOutstandingGame
		throws:
		(CancellationCard thrownAt: (SpeedCard thrownAt: 'Enterprise'))
		from: 'Enterprise'.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 5.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 3.

	anOutstandingGame
		throws: (RedoCard thrownAt: (SpeedCard thrownAt: 'Enterprise'))
		from: 'Enterprise'.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 7
]

{ #category : #tests }
CardTest >> testRedoRepeatsCancellationOfAnAcceleration [

	| aBoard anOutstandingGame aFiniteDeck cardAwarderEffect |
	aFiniteDeck := FiniteDeck of: 30 setWith: { 
			               AccelerationCard create.
			               AccelerationCard create.
			               AccelerationCard create.
			               AccelerationCard create.
			               CancellationCard create.
			               RedoCard create.
			               RedoCard create }.
	cardAwarderEffect := CardAwarderEffect associatedTo: aFiniteDeck.

	aBoard := Board
		          of: 10
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          with: { Box with: cardAwarderEffect }.

	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Enterprise'. 'Delorean' }
		                     on: aBoard
		                     throwing: (LoadedDie withSequence: { 1. 2. 3 })
		                     using: aFiniteDeck.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 1.
	anOutstandingGame throws: AccelerationCard from: 'Delorean'.
	anOutstandingGame throws: AccelerationCard from: 'Delorean'.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 4.
	anOutstandingGame
		throws: (CancellationCard thrownAt: AccelerationCard)
		from: 'Enterprise'.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 5.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 6.
	anOutstandingGame
		throws: (RedoCard thrownAt: AccelerationCard)
		from: 'Enterprise'.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 7
]

{ #category : #tests }
CardTest >> testRedoRepeatsCancellationOfAnOverload [

	| aBoard anOutstandingGame aFiniteDeck cardAwarderEffect |
	aFiniteDeck := FiniteDeck of: 30 setWith: { 
			               OverloadCard create.
			               OverloadCard create.
			               OverloadCard create.
			               OverloadCard create.
			               CancellationCard create.
			               RedoCard create.
			               RedoCard create }.
	cardAwarderEffect := CardAwarderEffect associatedTo: aFiniteDeck.

	aBoard := Board
		          of: 10
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          with: { (Box with: cardAwarderEffect) }.

	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Enterprise'. 'Delorean' }
		                     on: aBoard
		                     throwing: (LoadedDie withSequence: { 1. 2. 3 })
		                     using: aFiniteDeck.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 1.
	anOutstandingGame
		throws: (OverloadCard thrownAt: 'Enterprise')
		from: 'Delorean'.
	anOutstandingGame
		throws: (OverloadCard thrownAt: 'Enterprise')
		from: 'Delorean'.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 2.
	anOutstandingGame
		throws:
		(CancellationCard thrownAt: (OverloadCard thrownAt: 'Enterprise'))
		from: 'Enterprise'.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 2.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 3.
	anOutstandingGame
		throws: (RedoCard thrownAt: (OverloadCard thrownAt: 'Enterprise'))
		from: 'Enterprise'.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 4
]

{ #category : #tests }
CardTest >> testRedoRepeatsOverload [

	| aBoard cardAwarderEffect box1 box2 box3 box4 box5 anOutstandingGame aFiniteDeck |
	aFiniteDeck := FiniteDeck of: 30 setWith: { 
			               OverloadCard create.
			               OverloadCard create.
			               OverloadCard create.
			               OverloadCard create.
			               RedoCard create.
			               RedoCard create }.
		
	cardAwarderEffect := CardAwarderEffect associatedTo: aFiniteDeck.
	
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
		                     throwing: (LoadedDie withSequence: { 1. 2 })
		                     using: aFiniteDeck.
	anOutstandingGame play.
	anOutstandingGame
		throws: (OverloadCard thrownAt: 'Enterprise')
		from: 'Delorean'.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 2.
	anOutstandingGame
		throws: (RedoCard thrownAt: 'Delorean')
		from: 'Enterprise'.
	anOutstandingGame play.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 2
]

{ #category : #tests }
CardTest >> testRedoRepeatsSpeed [

	| aBoard cardAwarderEffect box1 box2 box3 box4 box5 anOutstandingGame aFiniteDeck |
	aFiniteDeck := FiniteDeck of: 30 setWith: { 
			               SpeedCard create.
			               SpeedCard create.
			               SpeedCard create.
			               SpeedCard create.
			               RedoCard create.
			               RedoCard create }.
	cardAwarderEffect := CardAwarderEffect associatedTo: aFiniteDeck.

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
		                     throwing: (LoadedDie withSequence: { 1. 2 })
		                     using: aFiniteDeck.
	anOutstandingGame play.
	anOutstandingGame
		throws: (SpeedCard thrownAt: 'Enterprise')
		from: 'Delorean'.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 2.
	anOutstandingGame
		throws: (RedoCard thrownAt: 'Delorean')
		from: 'Enterprise'.
	anOutstandingGame play.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 5
]

{ #category : #tests }
CardTest >> testRepeatReplaysAtomicBombEffect [

	| aBoard aCardDistribution box1 box2 box3 box4 box5 anOutstandingGame atomicBombEffect aFiniteDeck |
	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: RepeatCard).
	aFiniteDeck := FiniteDeck of: 100 with: aCardDistribution.
	atomicBombEffect := AtomicBombEffect create.

	box1 := Box with: NoEffect new.
	box2 := Box with: NoEffect new.
	box3 := Box with: NoEffect new.
	box4 := Box with: NoEffect new.
	box5 := Box with: atomicBombEffect.

	aBoard := Board
		          of: 20
		          and: (ParsecUnit of: 20)
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
		                     (LoadedDie withSequence: { 1. 4. 4. 6. 6 })
		                     using: aFiniteDeck.

	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 1.

	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 4.

	anOutstandingGame play.

	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 1.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 1.

	anOutstandingGame
		throws: (RepeatCard thrownAt: 'Delorean')
		from: 'Enterprise'.

	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 1.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 1
]

{ #category : #tests }
CardTest >> testRepeatReplaysCardAwarderEffect [

	| aBoard aCardDistribution box1 box2 box3 box4 box5 anOutstandingGame cardAwarderEffect aFiniteDeck |
	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: RepeatCard).
	aFiniteDeck := FiniteDeck of: 100 with: aCardDistribution.
	cardAwarderEffect := CardAwarderEffect associatedTo: aFiniteDeck.

	box1 := Box with: NoEffect new.
	box2 := Box with: NoEffect new.
	box3 := Box with: NoEffect new.
	box4 := Box with: NoEffect new.
	box5 := Box with: cardAwarderEffect.

	aBoard := Board
		          of: 20
		          and: (ParsecUnit of: 20)
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
		                     throwing: (LoadedDie withSequence: { 1. 4. 4 })
		                     using: aFiniteDeck.

	self assert: (anOutstandingGame deckOf: 'Enterprise') size equals: 2.
	self assert: (anOutstandingGame deckOf: 'Delorean') size equals: 2.

	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 1.

	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 4.

	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 5.


	anOutstandingGame
		throws: (RepeatCard thrownAt: 'Delorean')
		from: 'Enterprise'.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 5.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 4.

	self assert: (anOutstandingGame deckOf: 'Enterprise') size equals: 2.
	self assert: (anOutstandingGame deckOf: 'Delorean') size equals: 3
]

{ #category : #tests }
CardTest >> testRepeatReplaysHyperJumpEffect [

	| aBoard aCardDistribution box1 box2 box3 box4 box5 anOutstandingGame wormHoleEffect aFiniteDeck |
	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: RepeatCard).
	aFiniteDeck := FiniteDeck of: 100 with: aCardDistribution.
	wormHoleEffect := WormHoleEffect create.

	box1 := Box with: NoEffect new.
	box2 := Box with: NoEffect new.
	box3 := Box with: NoEffect new.
	box4 := Box with: NoEffect new.
	box5 := Box with: wormHoleEffect.

	aBoard := Board
		          of: 20
		          and: (ParsecUnit of: 20)
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
		                     throwing: (LoadedDie withSequence: { 1. 3. 4 })
		                     using: aFiniteDeck.

	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 1.

	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 3.

	anOutstandingGame play.

	anOutstandingGame
		throws: (RepeatCard thrownAt: 'Delorean')
		from: 'Enterprise'.

	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 1.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 1
]

{ #category : #tests }
CardTest >> testRepeatReplaysMoonWalkEffect [

	| aBoard aCardDistribution box1 box2 box3 box4 box5 anOutstandingGame moonWalkEffect aFiniteDeck |
	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: RepeatCard).
	aFiniteDeck := FiniteDeck of: 100 with: aCardDistribution.
	moonWalkEffect := MoonWalkEffect displacing: 2.

	box1 := Box with: NoEffect new.
	box2 := Box with: NoEffect new.
	box3 := Box with: NoEffect new.
	box4 := Box with: moonWalkEffect.
	box5 := Box with: NoEffect new.

	aBoard := Board
		          of: 20
		          and: (ParsecUnit of: 20)
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
		                     (LoadedDie withSequence: { 5. 3. 1. 1 })
		                     using: aFiniteDeck.

	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 5.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 0.


	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 5.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 3.

	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 6.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 3.

	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 4.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 4.

	anOutstandingGame
		throws: (RepeatCard thrownAt: 'Delorean')
		from: 'Enterprise'.

	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 2.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 4
]

{ #category : #tests }
CardTest >> testRepeatReplaysNoEffectOnPosition [

	| aBoard aCardDistribution box1 box2 box3 box4 box5 anOutstandingGame aFiniteDeck |
	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: RepeatCard).
	aFiniteDeck := FiniteDeck of: 100 with: aCardDistribution.
	box1 := Box with: NoEffect new.
	box2 := Box with: NoEffect new.
	box3 := Box with: NoEffect new.
	box4 := Box with: NoEffect new.
	box5 := Box with: NoEffect new.

	aBoard := Board
		          of: 20
		          and: (ParsecUnit of: 20)
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
		                     throwing: (LoadedDie withSequence: { 1. 3. 4 })
		                     using: aFiniteDeck.

	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 1.

	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 3.

	anOutstandingGame play.

	anOutstandingGame
		throws: (RepeatCard thrownAt: 'Delorean')
		from: 'Enterprise'.

	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 5.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 3
]

{ #category : #tests }
CardTest >> testRepeatReplaysSpeedUpEffect [

	| aBoard aCardDistribution box1 box2 box3 box4 box5 anOutstandingGame speedUpEffect aFiniteDeck |
	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: RepeatCard).
	aFiniteDeck := FiniteDeck of: 100 with: aCardDistribution.
	speedUpEffect := SpeedUpEffect create.

	box1 := Box with: speedUpEffect.
	box2 := Box with: NoEffect new.
	box3 := Box with: NoEffect new.
	box4 := Box with: NoEffect new.
	box5 := Box with: NoEffect new.

	aBoard := Board
		          of: 20
		          and: (ParsecUnit of: 20)
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
		                     throwing: (LoadedDie with: 1)
		                     using: aFiniteDeck.

	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 5.

	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 5.

	anOutstandingGame
		throws: (RepeatCard thrownAt: 'Delorean')
		from: 'Enterprise'.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 9
]

{ #category : #tests }
CardTest >> testRepeatReplaysWormHoleEffect [

	| aBoard aCardDistribution box1 box2 box3 box4 box5 anOutstandingGame wormHoleEffect aFiniteDeck |
	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: RepeatCard).
	aFiniteDeck := FiniteDeck of: 100 with: aCardDistribution.
	wormHoleEffect := WormHoleEffect create.

	box1 := Box with: NoEffect new.
	box2 := Box with: NoEffect new.
	box3 := Box with: NoEffect new.
	box4 := Box with: NoEffect new.
	box5 := Box with: wormHoleEffect.

	aBoard := Board
		          of: 20
		          and: (ParsecUnit of: 20)
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
		                     throwing: (LoadedDie withSequence: { 1. 3. 4 })
		                     using: aFiniteDeck.

	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 1.

	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 3.

	anOutstandingGame play.

	anOutstandingGame
		throws: (RepeatCard thrownAt: 'Delorean')
		from: 'Enterprise'.

	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 1.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 1
]

{ #category : #tests }
CardTest >> testSpeedCardIncreasesInOneTheSpaceshipDiceThrow [

	| aBoard aCardDistribution anOutstandingGame aFiniteDeck |
	aBoard := Board
		          of: 10
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          with: { (Box with: NoEffect new) }.
	aCardDistribution := OrderedCollection new.
	aCardDistribution add:
		(Distribution withProbabilityOf: 1 for: SpeedCard).
	aFiniteDeck := FiniteDeck of: 100 with: aCardDistribution.
	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Delorean'. 'Enterprise' }
		                     on: aBoard
		                     throwing: (LoadedDie withSequence: { 3. 4 })
		                     using: aFiniteDeck.
	anOutstandingGame
		throws: (SpeedCard thrownAt: 'Enterprise')
		from: 'Delorean'.
	anOutstandingGame play.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 3.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 5
]

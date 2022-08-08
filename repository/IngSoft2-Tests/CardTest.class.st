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
CardTest >> testACardIdsCantBeRepeated [

	| aBoard aCardDistribution anOutstandingGame |
	aCardDistribution := OrderedCollection new.
	aCardDistribution add:
		(Distribution withProbabilityOf: 1 for: OverloadCard).
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
		                     using: aCardDistribution
		                     for: 100.
	anOutstandingGame play.
	anOutstandingGame
				throws: (OverloadCard identifiedAs: '1' thrownAt: 'Enterprise')
				from: 'Enterprise'.

	self
		should: [ 
			anOutstandingGame
				throws: (OverloadCard identifiedAs: '1' thrownAt: 'Enterprise')
				from: 'Enterprise' ]
		raise: Error
		withMessage: 'Card names cant be repeated'.

	self assert: (anOutstandingGame deckOf: 'Enterprise') size equals: 1
]

{ #category : #tests }
CardTest >> testACardIsNotTakenAwayFromASpaceshipWhenThrownButNotItsTurn [

	| aBoard aCardDistribution anOutstandingGame |
	aCardDistribution := OrderedCollection new.
	aCardDistribution add:
		(Distribution withProbabilityOf: 1 for: OverloadCard).
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
		                     using: aCardDistribution
		                     for: 100.
	anOutstandingGame play.

	self
		should: [ 
			anOutstandingGame
				throws: (OverloadCard identifiedAs: '1' thrownAt: 'Enterprise')
				from: 'Delorean' ]
		raise: Error
		withMessage: 'Permanent cards can only be thrown in spaceships turn'.

	self assert: (anOutstandingGame deckOf: 'Enterprise') size equals: 2
]

{ #category : #tests }
CardTest >> testACardIsTakenAwayFromASpaceshipWhenThrown [

	| aBoard aCardDistribution anOutstandingGame |
	aBoard := Board
		          of: 10
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          with: { (Box with: NoEffect new) }.
	aCardDistribution := OrderedCollection new.
	aCardDistribution add:
		(Distribution withProbabilityOf: 1 for: OverloadCard).

	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Enterprise'. 'Delorean' }
		                     on: aBoard
		                     throwing: (LoadedDie with: 1)
		                     using: aCardDistribution
		                     for: 100.
	self assert: (anOutstandingGame deckOf: 'Enterprise') size equals: 2.

	anOutstandingGame
		throws: (OverloadCard identifiedAs: '1' thrownAt: 'Delorean')
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
	aCardDistribution add:
		(Distribution withProbabilityOf: 1 for: OverloadCard).

	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Delorean'. 'Enterprise' }
		                     on: aBoard
		                     throwing: (LoadedDie with: 1)
		                     using: aCardDistribution
		                     for: 100.

	self
		should: [ 
			anOutstandingGame
				throws: (SpeedCard identifiedAs: '1' thrownAt: 'Enterprise')
				from: 'Delorean' ]
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
	aCardDistribution add:
		(Distribution withProbabilityOf: 1 for: AccelerationCard).
	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany:
		                     { 'Enterprise'. 'Delorean'. 'Zathura' }
		                     on: aBoard
		                     throwing:
		                     (LoadedDie withSequence: { 3. 4. 5. 2. 2. 2 })
		                     using: aCardDistribution
		                     for: 100.

	anOutstandingGame throws: (AccelerationCard identifiedAs: '1') from: 'Enterprise'.

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
CardTest >> testAccelerationCardWithASpeedBoostCardIncreasesInTwoEachSpaceshipsDiceThrow [

	| aBoard anOutstandingGame |
	aBoard := Board
		          of: 30
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          with: { (Box with: NoEffect new) }.
	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Enterprise'. 'Delorean' }
		                     on: aBoard
		                     throwing: (LoadedDie with: 8)
		                     setting: { 
				                     AccelerationCard create.
				                     SpeedBoostCard create }
		                     for: 100.
	anOutstandingGame throws: (AccelerationCard identifiedAs: '1') from: 'Enterprise'.
	anOutstandingGame
		throws: (SpeedBoostCard identifiedAs: '2' thrownAt: '1')
		from: 'Enterprise'.
	anOutstandingGame play.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 10.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 10
]

{ #category : #tests }
CardTest >> testAllSpeedBoostEffectOnAccelerationCardAreRemovedAfterAccelerationCardIsCancelled [

	| aBoard anOutstandingGame |
	aBoard := Board
		          of: 30
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          with: { (Box with: CardGiverEffect new) }.

	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Enterprise'. 'Delorean' }
		                     on: aBoard
		                     throwing: (LoadedDie with: 1)
		                     setting: { 
				                     AccelerationCard create.
				                     AccelerationCard create.
				                     CancellationCard create.
				                     SpeedBoostCard create.
				                     RedoCard create.
				                     RedoCard create.
				                     RedoCard create.
				                     RedoCard create.
				                     RedoCard create.
				                     RedoCard create }
		                     for: 100.

	anOutstandingGame
		throws: (AccelerationCard identifiedAs: '1')
		from: 'Enterprise'.
	anOutstandingGame
		throws: (AccelerationCard identifiedAs: '2')
		from: 'Enterprise'.
	anOutstandingGame
		throws: (SpeedBoostCard identifiedAs: '3' thrownAt: '1')
		from: 'Delorean'.
	anOutstandingGame play.
	anOutstandingGame
		throws: (RedoCard identifiedAs: '4' thrownAt: NullCard new)
		from: 'Enterprise'.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 4.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 6.
	anOutstandingGame
		throws: (CancellationCard identifiedAs: '5'thrownAt: '1')
		from: 'Delorean'.
	anOutstandingGame play.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 6.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 8
]

{ #category : #tests }
CardTest >> testAllSpeedBoostsEffectOnOverloadCardCardAreRemovedAfterSpeedCardIsCancelled [

	| aBoard anOutstandingGame |
	aBoard := Board
		          of: 30
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          with: { (Box with: CardGiverEffect new) }.

	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Enterprise'. 'Delorean' }
		                     on: aBoard
		                     throwing: (LoadedDie with: 10)
		                     setting: { 
				                     OverloadCard create.
				                     OverloadCard create.
				                     CancellationCard create.
				                     SpeedBoostCard create.
				                     RedoCard create }
		                     for: 100.

	anOutstandingGame
		throws: (OverloadCard identifiedAs: '1' thrownAt: 'Enterprise')
		from: 'Enterprise'.
	anOutstandingGame
		throws: (OverloadCard identifiedAs: '2' thrownAt: 'Enterprise')
		from: 'Enterprise'.
	anOutstandingGame
		throws: (SpeedBoostCard identifiedAs: '3' thrownAt: '1')
		from: 'Delorean'.
	anOutstandingGame play.
	anOutstandingGame
		throws: (RedoCard identifiedAs: '4' thrownAt: '1')
		from: 'Enterprise'.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 4.
	anOutstandingGame play.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 4.
	anOutstandingGame
		throws: (CancellationCard identifiedAs: '5' thrownAt: '1')
		from: 'Delorean'.
	anOutstandingGame play.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 12
]

{ #category : #tests }
CardTest >> testAllSpeedBoostsEffectOnSpeedCardAreRemovedAfterSpeedCardIsCancelled [

	| aBoard anOutstandingGame aFiniteDeck |
	aFiniteDeck := Deck of: 100 setWith: { 
			               SpeedCard create.
			               SpeedCard create.
			               CancellationCard create.
			               SpeedBoostCard create.
			               RedoCard create }.
	aBoard := Board
		          of: 30
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          with: { (Box with: CardGiverEffect new) }.

	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Enterprise'. 'Delorean' }
		                     on: aBoard
		                     throwing: (LoadedDie with: 1)
		                     setting: { 
				                     SpeedCard create.
				                     SpeedCard create.
				                     CancellationCard create.
				                     SpeedBoostCard create.
				                     RedoCard create }
		                     for: 100.

	anOutstandingGame
		throws: (SpeedCard identifiedAs: '1' thrownAt: 'Enterprise')
		from: 'Enterprise'.
	anOutstandingGame
		throws: (SpeedCard identifiedAs: '2' thrownAt: 'Enterprise')
		from: 'Enterprise'.
	anOutstandingGame
		throws: (SpeedBoostCard identifiedAs: '3' thrownAt: '1')
		from: 'Delorean'.
	anOutstandingGame play.
	anOutstandingGame
		throws: (RedoCard identifiedAs: '4' thrownAt: '1')
		from: 'Enterprise'.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 4.
	anOutstandingGame play.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 10.
	anOutstandingGame
		throws: (CancellationCard identifiedAs: '5' thrownAt: '1')
		from: 'Delorean'.
	anOutstandingGame play.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 12
]

{ #category : #tests }
CardTest >> testAnInstantaneousCardCantBeUsedIfTheGameHasFinished [

	| aBoard cardAwarderEffect box1 box2 box3 box4 box5 anOutstandingGame |
	cardAwarderEffect := CardGiverEffect new.

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
		                     setting: { 
			               OverloadCard create.
			               OverloadCard create.
			               OverloadCard create.
			               OverloadCard create.
			               CancellationCard create.
			               CancellationCard create } for: 10.

	anOutstandingGame play.
	anOutstandingGame
		throws: (OverloadCard identifiedAs: '1' thrownAt: 'Enterprise')
		from: 'Delorean'.
	anOutstandingGame play.
	anOutstandingGame
		throws:
		(CancellationCard identifiedAs: '2'  thrownAt: '1')
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
				(CancellationCard  identifiedAs: '3' thrownAt: '1')
				from: 'Delorean' ]
		raise: Error
		withMessage: 'Cards can only be thrown if game has not finished'
]

{ #category : #tests }
CardTest >> testAnInstantaneousCardEffectAffectOnlyOnce [

	| aBoard cardAwarderEffect box1 box2 box3 box4 box5 anOutstandingGame |
	cardAwarderEffect := CardGiverEffect new.

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
		                     setting: { 
				                     OverloadCard create.
				                     OverloadCard create.
				                     OverloadCard create.
				                     OverloadCard create.
				                     CancellationCard create.
				                     CancellationCard create }
		                     for: 10.
	anOutstandingGame play.
	anOutstandingGame
		throws: (OverloadCard identifiedAs: '1' thrownAt: 'Enterprise')
		from: 'Delorean'.
	anOutstandingGame
		throws: (OverloadCard identifiedAs: '2' thrownAt: 'Enterprise')
		from: 'Delorean'.
	anOutstandingGame play.

	self
		assert: (anOutstandingGame deckOfCardAffecting: 'Enterprise') size
		equals: 2.

	anOutstandingGame
		throws:
		(CancellationCard  identifiedAs: '3' thrownAt: '1')
		from: 'Enterprise'.

	self
		assert: (anOutstandingGame deckOfCardAffecting: 'Enterprise') size
		equals: 1
]

{ #category : #tests }
CardTest >> testCancellationCardCantBePlayedIfTheChosenCardisNotInGame [

	| aBoard cardAwarderEffect box1 box2 box3 box4 box5 anOutstandingGame |
	cardAwarderEffect := CardGiverEffect new.

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
		                     setting: { 
				                     OverloadCard create.
				                     OverloadCard create.
				                     OverloadCard create.
				                     OverloadCard create.
				                     CancellationCard create.
				                     CancellationCard create }
		                     for: 10.
	anOutstandingGame play.
	anOutstandingGame
		throws: (OverloadCard identifiedAs: '1' thrownAt: 'Enterprise')
		from: 'Delorean'.
	anOutstandingGame play.
	self
		should: [ 
			anOutstandingGame
				throws:
				(CancellationCard identifiedAs: '2' thrownAt: '3')
				from: 'Enterprise' ]
		raise: Error
		withMessage:
		'Card cant be used if the chosen card is not in game'
]

{ #category : #tests }
CardTest >> testCancellationCardCantBePlayedIfThereAreNoPermanentCardsInGame [

	| aBoard aCardDistribution anOutstandingGame |
	aCardDistribution := OrderedCollection new.
	aCardDistribution add:
		(Distribution withProbabilityOf: 1 for: CancellationCard).
	aBoard := Board
		          of: 10
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          with: { (Box with: NoEffect new) }.

	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Enterprise'. 'Delorean' }
		                     on: aBoard
		                     throwing: (LoadedDie with: 1)
		                     using: aCardDistribution for: 10.

	self
		should: [ 
			anOutstandingGame
				throws: (CancellationCard identifiedAs: '2' thrownAt: 'Overload')
				from: 'Enterprise' ]
		raise: Error
		withMessage:
		'Cancellation card cant be used if there are no Permanet Cards in game'
]

{ #category : #tests }
CardTest >> testCancellationCardRemovesASpeedPermanentCard [

	| aBoard cardAwarderEffect box1 box2 box3 box4 box5 anOutstandingGame |
	cardAwarderEffect := CardGiverEffect new.

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
		                     setting: { 
				                     SpeedCard create.
				                     SpeedCard create.
				                     SpeedCard create.
				                     SpeedCard create.
				                     CancellationCard create.
				                     CancellationCard create }
		                     for: 10.
	anOutstandingGame play.

	anOutstandingGame
		throws: (SpeedCard identifiedAs: '1' thrownAt: 'Enterprise')
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
		throws:
		(CancellationCard identifiedAs: '2' thrownAt: '1')
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

	| aBoard cardAwarderEffect box1 box2 box3 box4 box5 anOutstandingGame |
	cardAwarderEffect := CardGiverEffect new.

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
		                     setting: { 
				                     AccelerationCard create.
				                     AccelerationCard create.
				                     AccelerationCard create.
				                     AccelerationCard create.
				                     CancellationCard create.
				                     CancellationCard create }
		                     for: 10.
	anOutstandingGame play.
	anOutstandingGame
		throws: (AccelerationCard identifiedAs: '1')
		from: 'Delorean'.
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
		throws: (CancellationCard identifiedAs: '2' thrownAt: '1')
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

	| aBoard cardAwarderEffect box1 box2 box3 box4 box5 anOutstandingGame |
	cardAwarderEffect := CardGiverEffect new.

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
		                     setting: { 
				                     OverloadCard create.
				                     OverloadCard create.
				                     OverloadCard create.
				                     OverloadCard create.
				                     CancellationCard create.
				                     CancellationCard create }
		                     for: 10.
	anOutstandingGame play.
	anOutstandingGame
		throws: (OverloadCard identifiedAs: '1' thrownAt: 'Enterprise')
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
		throws:
		(CancellationCard identifiedAs: '2' thrownAt: '1')
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

	| aBoard cardAwarderEffect box1 box2 box3 box4 box5 anOutstandingGame |
	cardAwarderEffect := CardGiverEffect new.

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
		                     setting: { 
				                     AccelerationCard create.
				                     AccelerationCard create.
				                     AccelerationCard create.
				                     AccelerationCard create.
				                     CancellationCard create.
				                     CancellationCard create }
		                     for: 10.
	anOutstandingGame play.
	anOutstandingGame
		throws: (AccelerationCard identifiedAs: '1')
		from: 'Delorean'.
	anOutstandingGame
		throws: (AccelerationCard identifiedAs: '2')
		from: 'Delorean'.
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
		throws: (CancellationCard identifiedAs: '3' thrownAt: '1')
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

	| aBoard aCardDistribution anOutstandingGame |
	aBoard := Board
		          of: 10
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          with: { (Box with: NoEffect new) }.

	aCardDistribution := OrderedCollection new.
	aCardDistribution add:
		(Distribution withProbabilityOf: 1 for: SpeedCard).
	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Enterprise'. 'Delorean' }
		                     on: aBoard
		                     throwing: (LoadedDie with: 1)
		                     using: aCardDistribution
		                     for: 100.

	anOutstandingGame
		throws: (SpeedCard identifiedAs: '1' thrownAt: 'Delorean')
		from: 'Enterprise'.
	anOutstandingGame
		throws: (SpeedCard identifiedAs: '2' thrownAt: 'Delorean')
		from: 'Enterprise'.
	anOutstandingGame play.
	anOutstandingGame play.

	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 1.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 3
]

{ #category : #tests }
CardTest >> testOverloadCardProducesSpaceshipToGoBackwards [

	| aBoard aCardDistribution anOutstandingGame |
	aBoard := Board
		          of: 10
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          with: { (Box with: NoEffect new) }.

	aCardDistribution := OrderedCollection new.
	aCardDistribution add:
		(Distribution withProbabilityOf: 1 for: OverloadCard).
	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Enterprise'. 'Delorean' }
		                     on: aBoard
		                     throwing:
		                     (LoadedDie withSequence: { 3. 4. 2. 1 })
		                     using: aCardDistribution for: 100.
	anOutstandingGame play.
	anOutstandingGame play.

	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 3.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 4.
	anOutstandingGame
		throws: (OverloadCard identifiedAs: '1' thrownAt: 'Delorean')
		from: 'Enterprise'.

	anOutstandingGame play.
	anOutstandingGame play.

	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 5.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 3
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
	aCardDistribution add:
		(Distribution withProbabilityOf: 1 for: OverloadCard).
	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Enterprise'. 'Delorean' }
		                     on: aBoard
		                     throwing: (LoadedDie withSequence: { 3. 4 })
		                     using: aCardDistribution
		                     for: 100.

	anOutstandingGame
		throws: (OverloadCard identifiedAs: '1' thrownAt: 'Delorean')
		from: 'Enterprise'.

	anOutstandingGame play.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 3.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 2
]

{ #category : #tests }
CardTest >> testOverloadCardWithASpeedBoostCardReducesInFourTheSpaceshipDiceThrow [

	| aBoard anOutstandingGame |
	aBoard := Board
		          of: 30
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          with: { (Box with: NoEffect new) }.
	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Enterprise'. 'Delorean' }
		                     on: aBoard
		                     throwing: (LoadedDie with: 8)
		                     setting: { 
				                     OverloadCard create.
				                     SpeedBoostCard create }
		                     for: 100.

	anOutstandingGame
		throws: (OverloadCard identifiedAs: '1' thrownAt: 'Delorean')
		from: 'Enterprise'.
	anOutstandingGame
		throws: (SpeedBoostCard  identifiedAs: '2' thrownAt: '1')
		from: 'Enterprise'.
	anOutstandingGame play.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 8.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 4
]

{ #category : #tests }
CardTest >> testRedoCantBePlayedIfNoCardHasBeenPlayedBefore [

	| aCardDistribution cardAwarderEffect box1 box2 box3 box4 box5 aBoard anOutstandingGame |
	aCardDistribution := OrderedCollection new.
	aCardDistribution add:
		(Distribution withProbabilityOf: 1 for: RedoCard).
	cardAwarderEffect := CardGiverEffect new.

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
		                     using: aCardDistribution
		                     for: 100.

	self
		should: [ 
			anOutstandingGame
				throws: (RedoCard identifiedAs: '1' thrownAt: 'Enterprise')
				from: 'Enterprise' ]
		raise: Error
		withMessage: 'No card has been played yet'
]

{ #category : #tests }
CardTest >> testRedoRepeatsAPreviousRedoCard [

	| aBoard cardAwarderEffect box1 box2 box3 box4 box5 anOutstandingGame |
	cardAwarderEffect := CardGiverEffect new.
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
		                     setting: { 
				                     SpeedCard create.
				                     SpeedCard create.
				                     SpeedCard create.
				                     SpeedCard create.
				                     RedoCard create.
				                     RedoCard create }
		                     for: 100.
	anOutstandingGame play.
	anOutstandingGame
		throws: (SpeedCard identifiedAs: '1' thrownAt: 'Enterprise')
		from: 'Delorean'.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 1.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 2.
	anOutstandingGame
		throws: (RedoCard identifiedAs: '2' thrownAt: 'Delorean')
		from: 'Enterprise'.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 3.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 5.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 5.
	anOutstandingGame
		throws: (RedoCard identifiedAs: '3' thrownAt: 'Enterprise')
		from: 'Delorean'.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 8.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 8.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 11.
	anOutstandingGame
		throws: (RedoCard identifiedAs: '4' thrownAt: 'Delorean')
		from: 'Enterprise'.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 11.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 15
]

{ #category : #tests }
CardTest >> testRedoRepeatsARepeatCard [

	| aBoard box1 box2 box3 box4 box5 anOutstandingGame cardAwarderRepeatEffect |
	cardAwarderRepeatEffect := CardGiverEffect new.

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
		                     setting: { 
				                     RedoCard create.
				                     RedoCard create.
				                     RedoCard create.
				                     RedoCard create.
				                     RepeatCard create.
				                     RepeatCard create }
		                     for: 30.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 2.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 7.

	anOutstandingGame
		throws: (RepeatCard identifiedAs: '1' thrownAt: 'Delorean')
		from: 'Enterprise'.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 11.
	anOutstandingGame
		throws: (RedoCard identifiedAs: '2' thrownAt: 'Delorean')
		from: 'Enterprise'.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 15
]

{ #category : #tests }
CardTest >> testRedoRepeatsAcceleration [

	| aBoard cardAwarderEffect box1 box2 box3 box4 box5 anOutstandingGame |
	cardAwarderEffect := CardGiverEffect new.

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
		                     setting: { 
				                     AccelerationCard create.
				                     AccelerationCard create.
				                     AccelerationCard create.
				                     AccelerationCard create.
				                     RedoCard create.
				                     RedoCard create }
		                     for: 30.
	anOutstandingGame play.
	anOutstandingGame throws: (AccelerationCard identifiedAs: '1') from: 'Delorean'.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 3.
	anOutstandingGame
		throws: (RedoCard identifiedAs: '2' thrownAt: NullCard new)
		from: 'Enterprise'.
	anOutstandingGame play.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 7
]

{ #category : #tests }
CardTest >> testRedoRepeatsCancellationOfASpeed [

	| aBoard cardAwarderEffect anOutstandingGame |
	cardAwarderEffect := CardGiverEffect new.

	aBoard := Board
		          of: 10
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          with: { (Box with: cardAwarderEffect) }.

	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Enterprise'. 'Delorean' }
		                     on: aBoard
		                     throwing: (LoadedDie withSequence: { 1. 2. 3 })
		                     setting: { 
			               SpeedCard create.
			               SpeedCard create.
			               SpeedCard create.
			               SpeedCard create.
			               CancellationCard create.
			               RedoCard create.
			               RedoCard create } for: 30.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 1.
	anOutstandingGame
		throws: (SpeedCard identifiedAs: '1' thrownAt: 'Enterprise')
		from: 'Delorean'.
	anOutstandingGame
		throws: (SpeedCard identifiedAs: '2' thrownAt: 'Enterprise')
		from: 'Delorean'.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 2.
	anOutstandingGame
		throws:
		(CancellationCard identifiedAs: '3' thrownAt: '1')
		from: 'Enterprise'.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 5.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 3.

	anOutstandingGame
		throws: (RedoCard identifiedAs: '4' thrownAt: '2')
		from: 'Enterprise'.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 7
]

{ #category : #tests }
CardTest >> testRedoRepeatsCancellationOfAnAcceleration [

	| aBoard anOutstandingGame cardAwarderEffect |
	cardAwarderEffect := CardGiverEffect new.

	aBoard := Board
		          of: 10
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          with: { (Box with: cardAwarderEffect) }.

	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Enterprise'. 'Delorean' }
		                     on: aBoard
		                     throwing: (LoadedDie withSequence: { 1. 2. 3 })
		                     setting: { 
				                     AccelerationCard create.
				                     AccelerationCard create.
				                     AccelerationCard create.
				                     AccelerationCard create.
				                     CancellationCard create.
				                     RedoCard create.
				                     RedoCard create }
		                     for: 30.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 1.
	anOutstandingGame
		throws: (AccelerationCard identifiedAs: '1')
		from: 'Delorean'.
	anOutstandingGame
		throws: (AccelerationCard identifiedAs: '2')
		from: 'Delorean'.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 4.
	anOutstandingGame
		throws: (CancellationCard identifiedAs: '3' thrownAt: '1')
		from: 'Enterprise'.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 5.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 6.
	anOutstandingGame
		throws: (RedoCard identifiedAs: '4' thrownAt: '2')
		from: 'Enterprise'.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 7
]

{ #category : #tests }
CardTest >> testRedoRepeatsCancellationOfAnOverload [

	| aBoard anOutstandingGame cardAwarderEffect |
	cardAwarderEffect := CardGiverEffect new.

	aBoard := Board
		          of: 10
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          with: { (Box with: cardAwarderEffect) }.

	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Enterprise'. 'Delorean' }
		                     on: aBoard
		                     throwing: (LoadedDie withSequence: { 1. 2. 3 })
		                     setting: { 
				                     OverloadCard create.
				                     OverloadCard create.
				                     OverloadCard create.
				                     OverloadCard create.
				                     CancellationCard create.
				                     RedoCard create.
				                     RedoCard create }
		                     for: 30.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 1.
	anOutstandingGame
		throws: (OverloadCard identifiedAs: '1' thrownAt: 'Enterprise')
		from: 'Delorean'.
	anOutstandingGame
		throws: (OverloadCard identifiedAs: '2' thrownAt: 'Enterprise')
		from: 'Delorean'.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 2.
	anOutstandingGame
		throws: (CancellationCard identifiedAs: '3' thrownAt: '2')
		from: 'Enterprise'.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 2.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 3.
	anOutstandingGame
		throws: (RedoCard identifiedAs: '4' thrownAt: '1')
		from: 'Enterprise'.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 4
]

{ #category : #tests }
CardTest >> testRedoRepeatsOverload [

	| aBoard cardAwarderEffect box1 box2 box3 box4 box5 anOutstandingGame |
	cardAwarderEffect := CardGiverEffect new.

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
		                     setting: { 
				                     OverloadCard create.
				                     OverloadCard create.
				                     OverloadCard create.
				                     OverloadCard create.
				                     RedoCard create.
				                     RedoCard create }
		                     for: 30.
	anOutstandingGame play.
	anOutstandingGame
		throws: (OverloadCard identifiedAs: '1' thrownAt: 'Enterprise')
		from: 'Delorean'.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 2.
	anOutstandingGame
		throws: (RedoCard identifiedAs: '2' thrownAt: 'Delorean')
		from: 'Enterprise'.
	anOutstandingGame play.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 2
]

{ #category : #tests }
CardTest >> testRedoRepeatsSpeed [

	| aBoard cardAwarderEffect box1 box2 box3 box4 box5 anOutstandingGame |
	cardAwarderEffect := CardGiverEffect new.

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
		                     setting: { 
			               SpeedCard create.
			               SpeedCard create.
			               SpeedCard create.
			               SpeedCard create.
			               RedoCard create.
			               RedoCard create } for: 30.
	anOutstandingGame play.
	anOutstandingGame
		throws: (SpeedCard identifiedAs: '1' thrownAt: 'Enterprise')
		from: 'Delorean'.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 2.
	anOutstandingGame
		throws: (RedoCard identifiedAs: '2' thrownAt: 'Delorean')
		from: 'Enterprise'.
	anOutstandingGame play.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 5
]

{ #category : #tests }
CardTest >> testRedoRepeatsSpeedBoost [

	| aBoard anOutstandingGame |
	aBoard := Board
		          of: 30
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          with: { (Box with: NoEffect new) }.

	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Enterprise'. 'Delorean' }
		                     on: aBoard
		                     throwing: (LoadedDie with: 1)
		                     setting: { 
				                     SpeedCard create.
				                     SpeedBoostCard create.
				                     RedoCard create.
				                     RedoCard create }
		                     for: 30.

	anOutstandingGame
		throws: (SpeedCard identifiedAs: '1' thrownAt: 'Enterprise')
		from: 'Enterprise'.
	anOutstandingGame
		throws: (SpeedBoostCard identifiedAs: '2' thrownAt: '1')
		from: 'Enterprise'.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 3.
	anOutstandingGame
		throws: (RedoCard identifiedAs: '3' thrownAt: 'Enterprise')
		from: 'Delorean'.
	anOutstandingGame play.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 8
]

{ #category : #tests }
CardTest >> testRepeatReplaysAtomicBombEffect [

	| aBoard aCardDistribution box1 box2 box3 box4 box5 anOutstandingGame atomicBombEffect |
	aCardDistribution := OrderedCollection new.
	aCardDistribution add:
		(Distribution withProbabilityOf: 1 for: RepeatCard).
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
		                     using: aCardDistribution
		                     for: 100.

	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 1.

	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 4.

	anOutstandingGame play.

	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 1.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 1.

	anOutstandingGame
		throws: (RepeatCard identifiedAs: '1' thrownAt: 'Delorean')
		from: 'Enterprise'.

	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 1.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 1
]

{ #category : #tests }
CardTest >> testRepeatReplaysCardAwarderEffect [

	| aBoard aCardDistribution box1 box2 box3 box4 box5 anOutstandingGame cardAwarderEffect |
	aCardDistribution := OrderedCollection new.
	aCardDistribution add:
		(Distribution withProbabilityOf: 1 for: RepeatCard).
	cardAwarderEffect := CardGiverEffect new.

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
		                     using: aCardDistribution
		                     for: 100.

	self assert: (anOutstandingGame deckOf: 'Enterprise') size equals: 2.
	self assert: (anOutstandingGame deckOf: 'Delorean') size equals: 2.

	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 1.

	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 4.

	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 5.


	anOutstandingGame
		throws: (RepeatCard identifiedAs: '1' thrownAt: 'Delorean')
		from: 'Enterprise'.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 5.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 4.

	self assert: (anOutstandingGame deckOf: 'Enterprise') size equals: 2.
	self assert: (anOutstandingGame deckOf: 'Delorean') size equals: 3
]

{ #category : #tests }
CardTest >> testRepeatReplaysHyperJumpEffect [

	| aBoard aCardDistribution box1 box2 box3 box4 box5 anOutstandingGame wormHoleEffect |
	aCardDistribution := OrderedCollection new.
	aCardDistribution add:
		(Distribution withProbabilityOf: 1 for: RepeatCard).
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
		                     using: aCardDistribution
		                     for: 100.

	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 1.

	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 3.

	anOutstandingGame play.

	anOutstandingGame
		throws: (RepeatCard identifiedAs: '1' thrownAt: 'Delorean')
		from: 'Enterprise'.

	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 1.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 1
]

{ #category : #tests }
CardTest >> testRepeatReplaysMoonWalkEffect [

	| aBoard aCardDistribution box1 box2 box3 box4 box5 anOutstandingGame moonWalkEffect |
	aCardDistribution := OrderedCollection new.
	aCardDistribution add:
		(Distribution withProbabilityOf: 1 for: RepeatCard).
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
		                     using: aCardDistribution
		                     for: 100.

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
		throws: (RepeatCard identifiedAs: '1' thrownAt: 'Delorean')
		from: 'Enterprise'.

	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 2.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 4
]

{ #category : #tests }
CardTest >> testRepeatReplaysNoEffectOnPosition [

	| aBoard aCardDistribution box1 box2 box3 box4 box5 anOutstandingGame |
	aCardDistribution := OrderedCollection new.
	aCardDistribution add:
		(Distribution withProbabilityOf: 1 for: RepeatCard).
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
		                     using: aCardDistribution
		                     for: 100.

	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 1.

	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 3.

	anOutstandingGame play.

	anOutstandingGame
		throws: (RepeatCard identifiedAs: '1' thrownAt: 'Delorean')
		from: 'Enterprise'.

	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 5.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 3
]

{ #category : #tests }
CardTest >> testRepeatReplaysSpeedUpEffect [

	| aBoard aCardDistribution box1 box2 box3 box4 box5 anOutstandingGame speedUpEffect |
	aCardDistribution := OrderedCollection new.
	aCardDistribution add:
		(Distribution withProbabilityOf: 1 for: RepeatCard).
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
		                     using: aCardDistribution
		                     for: 100.

	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 5.

	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 5.

	anOutstandingGame
		throws: (RepeatCard identifiedAs: '1' thrownAt: 'Delorean')
		from: 'Enterprise'.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 9
]

{ #category : #tests }
CardTest >> testRepeatReplaysWormHoleEffect [

	| aBoard aCardDistribution box1 box2 box3 box4 box5 anOutstandingGame wormHoleEffect |
	aCardDistribution := OrderedCollection new.
	aCardDistribution add:
		(Distribution withProbabilityOf: 1 for: RepeatCard).
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
		                     using: aCardDistribution
		                     for: 100.

	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 1.

	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 3.

	anOutstandingGame play.

	anOutstandingGame
		throws: (RepeatCard identifiedAs: '1' thrownAt: 'Delorean')
		from: 'Enterprise'.

	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 1.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 1
]

{ #category : #tests }
CardTest >> testSpeedBoostCardCantBePlayedIfTheChosenCardisNotInGame [

	| aBoard cardAwarderEffect anOutstandingGame |
	cardAwarderEffect := CardGiverEffect new.

	aBoard := Board
		          of: 10
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          with: { (Box with: NoEffect new) }.

	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Enterprise'. 'Delorean' }
		                     on: aBoard
		                     throwing: (LoadedDie with: 1)
		                     setting: { SpeedBoostCard create }
		                     for: 10.
	self
		should: [ 
			anOutstandingGame
				throws:
				(SpeedBoostCard  identifiedAs: '1' thrownAt: '2')
				from: 'Enterprise' ]
		raise: Error
		withMessage:
		'Card cant be used if the chosen card is not in game'
]

{ #category : #tests }
CardTest >> testSpeedBoostEffectOnSpeedCardIsRemovedAfterSpeedCardIsCancelledAndDoesntAffectNewSpeedcards [

	| aBoard anOutstandingGame |
	aBoard := Board
		          of: 30
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          with: { (Box with: CardGiverEffect new) }.
	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Enterprise'. 'Delorean' }
		                     on: aBoard
		                     throwing: (LoadedDie with: 4)
		                     setting: { 
				                     SpeedCard create.
				                     SpeedCard create.
				                     CancellationCard create.
				                     SpeedBoostCard create }
		                     for: 30.

	anOutstandingGame
		throws: (SpeedCard identifiedAs: '1' thrownAt: 'Enterprise')
		from: 'Enterprise'.
	anOutstandingGame
		throws: (SpeedCard identifiedAs: '2' thrownAt: 'Enterprise')
		from: 'Enterprise'.
	anOutstandingGame
		throws: (SpeedBoostCard identifiedAs: '3' thrownAt: '1')
		from: 'Delorean'.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 7.
	anOutstandingGame
		throws: (CancellationCard identifiedAs: '4' thrownAt: '1')
		from: 'Delorean'.
	anOutstandingGame play.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 12.
	anOutstandingGame
		throws: (SpeedCard identifiedAs: '5' thrownAt: 'Enterprise')
		from: 'Delorean'.
	anOutstandingGame play.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 18
]

{ #category : #tests }
CardTest >> testSpeedBoostIsOnlyApliedToOnePermantIfTwoPresent [

	| aBoard anOutstandingGame |
	aBoard := Board
		          of: 30
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          with: { (Box with: NoEffect new) }.
	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Enterprise'. 'Delorean' }
		                     on: aBoard
		                     throwing: (LoadedDie with: 4)
		                     setting: { 
				                     SpeedCard create.
				                     SpeedBoostCard create }
		                     for: 100.

	anOutstandingGame
		throws: (SpeedCard identifiedAs: '1' thrownAt: 'Delorean')
		from: 'Enterprise'.
	anOutstandingGame play.
	anOutstandingGame
		throws: (SpeedCard identifiedAs: '2' thrownAt: 'Delorean')
		from: 'Delorean'.
	anOutstandingGame
		throws: (SpeedBoostCard identifiedAs: '3' thrownAt: '1')
		from: 'Delorean'.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 4.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 7
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
	aCardDistribution add:
		(Distribution withProbabilityOf: 1 for: SpeedCard).
	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Delorean'. 'Enterprise' }
		                     on: aBoard
		                     throwing: (LoadedDie withSequence: { 3. 4 })
		                     using: aCardDistribution
		                     for: 100.
	anOutstandingGame
		throws: (SpeedCard identifiedAs: '1' thrownAt: 'Enterprise')
		from: 'Delorean'.
	anOutstandingGame play.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 3.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 5
]

{ #category : #tests }
CardTest >> testSpeedCardWithASpeedBoostCardIncreasesInTwoTheSpaceshipDiceThrow [

	| aBoard anOutstandingGame |
	aBoard := Board
		          of: 30
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          with: { (Box with: NoEffect new) }.
	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Enterprise'. 'Delorean' }
		                     on: aBoard
		                     throwing: (LoadedDie with: 8)
		                     setting: { 
				                     SpeedCard create.
				                     SpeedBoostCard create }
		                     for: 100.

	anOutstandingGame
		throws: (SpeedCard identifiedAs: '1' thrownAt: 'Delorean')
		from: 'Enterprise'.
	anOutstandingGame
		throws: (SpeedBoostCard
				 identifiedAs: '2'
				 thrownAt: '1')
		from: 'Enterprise'.
	anOutstandingGame play.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 8.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 10
]

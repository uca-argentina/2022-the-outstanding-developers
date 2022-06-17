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
		                     (LoadedDie withSequence: {1. 1. 1. 1. 1. 1. 8})
		                     using: aCardDistribution.
	anOutstandingGame play.
	anOutstandingGame
		throws: (OverloadCard thrownAt: 'Enterprise' asA: PermanentCard)
		from: 'Delorean'.
	anOutstandingGame play.
	anOutstandingGame
		throws: (CancellationCard
				 thrownAt: (OverloadCard thrownAt: 'Enterprise')
				 asA: InstantaneousCard)
		from: 'Enterprise'.
	anOutstandingGame play.
	anOutstandingGame play.
	anOutstandingGame play.
	anOutstandingGame play.
	anOutstandingGame play.
	self
		should: [ anOutstandingGame
		throws: (CancellationCard
				 thrownAt: (OverloadCard thrownAt: 'Enterprise')
				 asA: InstantaneousCard)
		from: 'Enterprise'. ]
		raise: Error
		withMessage: 'Cards can only be thrown if game has not finished'
]

{ #category : #tests }
CardTest >> testAnInstantaneousCardEffectAffectOnlyOnce [

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
	anOutstandingGame
		throws: (OverloadCard thrownAt: 'Enterprise' asA: PermanentCard)
		from: 'Delorean'.
	anOutstandingGame play.
	
	self assert: (anOutstandingGame cardsAffectingOf: 'Enterprise') size equals: 2.
	
	anOutstandingGame
		throws: (CancellationCard
				 thrownAt: (OverloadCard thrownAt: 'Enterprise')
				 asA: InstantaneousCard)
		from: 'Enterprise'.
	
	self assert: (anOutstandingGame cardsAffectingOf: 'Enterprise') size equals: 1.
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
						 thrownAt: (SpeedCard thrownAt: 'Delorean')
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
CardTest >> testCancellationCardRemovesASpeedPermanentCard [

	| aBoard aCardDistribution anotherCardDistribution cardAwarderEffect box1 box2 box3 box4 box5 anOutstandingGame |
	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: (SpeedCard behavingAsA: PermanentCard)).
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
		throws: (SpeedCard thrownAt: 'Enterprise' asA: PermanentCard)
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
				 asA: InstantaneousCard)
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

	| aBoard aCardDistribution anotherCardDistribution cardAwarderEffect box1 box2 box3 box4 box5 anOutstandingGame |
	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: (AccelerationCard behavingAsA: PermanentCard)).
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
		throws: (AccelerationCard behavingAsA: PermanentCard)
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
		throws: (CancellationCard
				 thrownAt: AccelerationCard
				 asA: InstantaneousCard)
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
				 asA: InstantaneousCard)
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

	| aBoard aCardDistribution anotherCardDistribution cardAwarderEffect box1 box2 box3 box4 box5 anOutstandingGame |
	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: (AccelerationCard behavingAsA: PermanentCard)).
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
		                     using: aCardDistribution.
	anOutstandingGame play.
	anOutstandingGame
		throws: (AccelerationCard behavingAsA: PermanentCard)
		from: 'Delorean'.
	anOutstandingGame
		throws: (AccelerationCard behavingAsA: PermanentCard)
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
		throws:
		(CancellationCard thrownAt: AccelerationCard asA: InstantaneousCard)
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

	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 1.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 3
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
	
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 3.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 4.
	anOutstandingGame throws: (OverloadCard thrownAt: 'Delorean' asA: PermanentCard) from: 'Enterprise'. 

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
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 3.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 2
]

{ #category : #tests }
CardTest >> testRedoCantBePlayedIfNoCardHasBeenPlayedBefore [

	| aCardDistribution cardAwarderEffect box1 box2 box3 box4 box5 aBoard anOutstandingGame |
	aCardDistribution := OrderedCollection new.
	aCardDistribution add:
		(Distribution withProbabilityOf: 1 for: RedoCard).
	cardAwarderEffect := CardAwarderEffect with: aCardDistribution.

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
		                     using: aCardDistribution.

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

	| aBoard aCardDistribution anotherCardDistribution cardAwarderEffect box1 box2 box3 box4 box5 anOutstandingGame |
	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: (SpeedCard behavingAsA: PermanentCard)).
	anotherCardDistribution := OrderedCollection new.
	anotherCardDistribution add:
		(Distribution withProbabilityOf: 1 for: RedoCard).
	cardAwarderEffect := CardAwarderEffect with: anotherCardDistribution.

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
		                     using: aCardDistribution.
	anOutstandingGame play.
	anOutstandingGame
		throws: (SpeedCard thrownAt: 'Enterprise' asA: PermanentCard)
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
CardTest >> testRedoRepeatsAcceleration [

	| aBoard aCardDistribution anotherCardDistribution cardAwarderEffect box1 box2 box3 box4 box5 anOutstandingGame |
	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: (AccelerationCard behavingAsA: PermanentCard)).
	anotherCardDistribution := OrderedCollection new.
	anotherCardDistribution add:
		(Distribution withProbabilityOf: 1 for: RedoCard).
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
		                     (LoadedDie withSequence: { 1. 2 })
		                     using: aCardDistribution.
	anOutstandingGame play.
	anOutstandingGame
		throws: (AccelerationCard behavingAsA: PermanentCard)
		from: 'Delorean'.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 3.
	anOutstandingGame throws: (RedoCard thrownAt: EmptyCard new) from: 'Enterprise'.
	anOutstandingGame play.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 7.
]

{ #category : #tests }
CardTest >> testRedoRepeatsCancellation [

	| aBoard aCardDistribution anotherCardDistribution box1 box2 box3 box4 box5 anOutstandingGame cancellationCardAwarderEffect otherCardDistribution redoCardAwarderEffect |
	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: (OverloadCard behavingAsA: PermanentCard)).
	anotherCardDistribution := OrderedCollection new.
	anotherCardDistribution add:
		(Distribution withProbabilityOf: 1 for: CancellationCard).
	otherCardDistribution := OrderedCollection new.
	otherCardDistribution add:
		(Distribution withProbabilityOf: 1 for: RedoCard).
	cancellationCardAwarderEffect := CardAwarderEffect with:
		                                 anotherCardDistribution.
	redoCardAwarderEffect := CardAwarderEffect with:
		                         otherCardDistribution.

	box1 := Box with: cancellationCardAwarderEffect.
	box2 := Box with: redoCardAwarderEffect.
	box3 := Box with: redoCardAwarderEffect.
	box4 := Box with: redoCardAwarderEffect.
	box5 := Box with: redoCardAwarderEffect.

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
		                     throwing: (LoadedDie withSequence: { 1. 2. 3 })
		                     using: aCardDistribution.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 1.
	anOutstandingGame
		throws: (OverloadCard thrownAt: 'Enterprise' asA: PermanentCard)
		from: 'Delorean'.
	anOutstandingGame
		throws: (OverloadCard thrownAt: 'Enterprise' asA: PermanentCard)
		from: 'Delorean'.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 2.
	anOutstandingGame
		throws: (CancellationCard
				 thrownAt: (OverloadCard thrownAt: 'Enterprise')
				 asA: InstantaneousCard)
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

	| aBoard aCardDistribution anotherCardDistribution cardAwarderEffect box1 box2 box3 box4 box5 anOutstandingGame |
	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: (OverloadCard behavingAsA: PermanentCard)).
	anotherCardDistribution := OrderedCollection new.
	anotherCardDistribution add:
		(Distribution withProbabilityOf: 1 for: RedoCard).
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
		                     (LoadedDie withSequence: { 1. 2 })
		                     using: aCardDistribution.
	anOutstandingGame play.
	anOutstandingGame
		throws: (OverloadCard thrownAt: 'Enterprise' asA: PermanentCard)
		from: 'Delorean'.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 2.
	anOutstandingGame throws: (RedoCard thrownAt: 'Delorean') from: 'Enterprise'.
	anOutstandingGame play.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 2.
]

{ #category : #tests }
CardTest >> testRedoRepeatsSpeed [

	| aBoard aCardDistribution anotherCardDistribution cardAwarderEffect box1 box2 box3 box4 box5 anOutstandingGame |
	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: (SpeedCard behavingAsA: PermanentCard)).
	anotherCardDistribution := OrderedCollection new.
	anotherCardDistribution add:
		(Distribution withProbabilityOf: 1 for: RedoCard).
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
		                     (LoadedDie withSequence: { 1. 2 })
		                     using: aCardDistribution.
	anOutstandingGame play.
	anOutstandingGame
		throws: (SpeedCard thrownAt: 'Enterprise' asA: PermanentCard)
		from: 'Delorean'.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 2.
	anOutstandingGame throws: (RedoCard thrownAt: 'Delorean') from: 'Enterprise'.
	anOutstandingGame play.
	anOutstandingGame play.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 5.
]

{ #category : #tests }
CardTest >> testRepeatReplaysAtomicBombEffect [

	| aBoard aCardDistribution box1 box2 box3 box4 box5 anOutstandingGame atomicBombEffect |
	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: (RepeatCard behavingAsA: InstantaneousCard)).

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
		                     using: aCardDistribution.

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

	| aBoard aCardDistribution box1 box2 box3 box4 box5 anOutstandingGame cardAwarderEffect |
	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: (RepeatCard behavingAsA: InstantaneousCard)).

	cardAwarderEffect := CardAwarderEffect with: aCardDistribution.

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
		                     using: aCardDistribution.

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

	| aBoard aCardDistribution box1 box2 box3 box4 box5 anOutstandingGame wormHoleEffect |
	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: (RepeatCard behavingAsA: InstantaneousCard)).

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
		                     using: aCardDistribution.

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

	| aBoard aCardDistribution box1 box2 box3 box4 box5 anOutstandingGame moonWalkEffect |
	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: (RepeatCard behavingAsA: InstantaneousCard)).

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
		                     using: aCardDistribution.

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

	| aBoard aCardDistribution box1 box2 box3 box4 box5 anOutstandingGame |
	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: (RepeatCard behavingAsA: InstantaneousCard)).

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
		                     using: aCardDistribution.

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

	| aBoard aCardDistribution box1 box2 box3 box4 box5 anOutstandingGame speedUpEffect |
	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: (RepeatCard behavingAsA: InstantaneousCard)).
	
	speedUpEffect := SpeedUpEffect create.

	box1 := Box with: speedUpEffect .
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
		                     using: aCardDistribution.
	
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

	| aBoard aCardDistribution box1 box2 box3 box4 box5 anOutstandingGame wormHoleEffect |
	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: (RepeatCard behavingAsA: InstantaneousCard)).

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
		                     using: aCardDistribution.

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
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 3.
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 5
]

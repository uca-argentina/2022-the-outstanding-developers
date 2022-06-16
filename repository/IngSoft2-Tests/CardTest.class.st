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
CardTest >> testCancellationCardRemovesAPermanentCard [

	| cancellationCard aBoard delorean enterprise overloadCard |
	cancellationCard := CancellationCard asA: InstantaneousCard new.
	overloadCard := OverloadCard asA: PermanentCard new.
	delorean := Spaceship called: 'Delorean'.
	enterprise := Spaceship called: 'Enterprise'.
"	delorean receives: overloadCard.
	delorean receives: cancellationCard.
	El juego se las debe dar"

	aBoard := Board
		          of: 10
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          with: { (Box with: NoEffect new) }.
		

	"delorean throw: 1 to: 'Enterprise' in: aBoard.
	delorean throw: 1 to: (CardWithPlayer withPlayer: 'Enterprise' and: 'overload') in: aBoard."
	self
		should: [ delorean throw: 1 to: 'Enterprise' in: aBoard ]
		raise: Error
		withMessage: 'No se, algun error'
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

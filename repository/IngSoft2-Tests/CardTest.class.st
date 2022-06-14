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

	| overloadCard enterprise aBoard delorean collectionOfCards |
	overloadCard := OverloadCard asA: PermanentCard new.
	delorean := Spaceship called: 'Delorean'.
	enterprise := Spaceship called: 'Enterprise'.
	enterprise receives: overloadCard.
	aBoard := Board
		          of: 10
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          byMany: { 
				          enterprise.
				          delorean }
		          with: { (Box with: NoEffect new) }.
	aBoard moveSpaceship: 3.
	
	self
		should: [ enterprise throw: 1 to: 'Delorean' in: aBoard ]
		raise: Error
		withMessage: 'Permanent cards can only be thrown in spaceships turn'.
		
	collectionOfCards := OrderedCollection new.
	collectionOfCards add: overloadCard.
	self assert: enterprise cardDeck equals: collectionOfCards.
	self assert: (aBoard cardDeckOf: 'Delorean') equals: OrderedCollection new.
	
]

{ #category : #tests }
CardTest >> testACardIsTakenAwayFromASpaceshipWhenThrown [

	| overloadCard enterprise aBoard delorean |
	overloadCard := OverloadCard  asA: PermanentCard new.

	enterprise := Spaceship called: 'Enterprise'.
	enterprise receives: overloadCard.

	delorean := Spaceship called: 'Delorean'.
	aBoard := Board
		          of: 10
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          byMany: { 
				          enterprise.
				          delorean }
		          with: { Box with: NoEffect new }.
	enterprise throw: 1 to: 'Delorean' in: aBoard.

	self assert: (aBoard cardDeckOf: 'Enterprise') equals: (OrderedCollection new).
]

{ #category : #tests }
CardTest >> testAPermanentCardCantBeUsedIfItIsNotTheSpaceshipsTurn [

	| overloadCard enterprise aBoard delorean |
	overloadCard := OverloadCard asA: PermanentCard new.
	delorean := Spaceship called: 'Delorean'.
	enterprise := Spaceship called: 'Enterprise'.
	enterprise receives: overloadCard.
	aBoard := Board
		          of: 10
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          byMany: { 
				          enterprise.
				          delorean }
		          with: { (Box with: NoEffect new) }.
	aBoard moveSpaceship: 3.
	self
		should: [ enterprise throw: 1 to: 'Delorean' in: aBoard ]
		raise: Error
		withMessage: 'Permanent cards can only be thrown in spaceships turn'
]

{ #category : #tests }
CardTest >> testASpaceshipThrowsACardToAnotherOneAndItBecomesPartOfTheGame [

	| speedCard enterprise aBoard delorean collectionOfCards |
	speedCard := SpeedCard asA: PermanentCard new.

	enterprise := Spaceship called: 'Enterprise'.
	enterprise receives: speedCard.

	delorean := Spaceship called: 'Delorean'.
	aBoard := Board
		          of: 10
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          byMany: { 
				          enterprise.
				          delorean }
		          with: { Box with: NoEffect new }.
	enterprise throw: 1 to: 'Delorean' in: aBoard.

	collectionOfCards := OrderedCollection new.
	collectionOfCards add: speedCard.
	self assert: (aBoard cardDeckOf: 'Delorean') equals: collectionOfCards
]

{ #category : #tests }
CardTest >> testAccelerationCardIncreasesInOneAllTheSpaceshipsDiceThrows [

	| accelerationCard enterprise aBoard delorean zathura |
	
	accelerationCard := AccelerationCard asA: PermanentCard new.

	enterprise := Spaceship called: 'Enterprise'.
	delorean := Spaceship called: 'Delorean'.
	zathura := Spaceship called: 'Zathura'.
	enterprise receives: accelerationCard.
	
	aBoard := Board
		          of: 10
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          byMany: { 
				          enterprise.
				          delorean. zathura}
		          with: { (Box with: NoEffect new) }.
	enterprise throw: 1 in: aBoard.
	aBoard moveSpaceship: 3.
	aBoard moveSpaceship: 4.
	aBoard moveSpaceship: 5.
	self assert: (aBoard positionOf: 'Enterprise') equals: 4.
	self assert: (aBoard positionOf: 'Delorean') equals: 5.
	self assert: (aBoard positionOf: 'Zathura') equals: 6.
	aBoard moveSpaceship: 2.
	aBoard moveSpaceship: 2.
	aBoard moveSpaceship: 2.
	self assert: (aBoard positionOf: 'Enterprise') equals: 7.
	self assert: (aBoard positionOf: 'Delorean') equals: 8.
	self assert: (aBoard positionOf: 'Zathura') equals: 9.
]

{ #category : #tests }
CardTest >> testEffectOfMultipleCardsIsAddesUpIntoTheSpaceshipDiceThrow [

	| anOverloadCard enterprise aBoard delorean aSpeedCard anotherSpeedCard |
	anOverloadCard := OverloadCard asA: PermanentCard new.
	aSpeedCard := SpeedCard asA: PermanentCard new.
	anotherSpeedCard := SpeedCard asA: PermanentCard new.

	enterprise := Spaceship called: 'Enterprise'.
	enterprise receivesMany: { 
			anOverloadCard.
			aSpeedCard.
			anotherSpeedCard }.

	delorean := Spaceship called: 'Delorean'.
	aBoard := Board
		          of: 10
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          byMany: { 
				          enterprise.
				          delorean }
		          with: { (Box with: NoEffect new) }.
	enterprise throw: 1 to: 'Delorean' in: aBoard.
	enterprise throw: 2 to: 'Delorean' in: aBoard.
	enterprise throw: 1 to: 'Delorean' in: aBoard.
	aBoard moveSpaceship: 3.
	aBoard moveSpaceship: 4.
	self assert: (aBoard positionOf: 'Enterprise') equals: 3.
	self assert: (aBoard positionOf: 'Delorean') equals: 4
]

{ #category : #tests }
CardTest >> testOverloadCardProducesSpaceshipToGoBackwards [
"Cual es el sentido de este si está el de ReducesInTwo?"
	| overloadCard enterprise aBoard delorean |
	overloadCard := OverloadCard  asA: PermanentCard new.

	enterprise := Spaceship called: 'Enterprise'.
	enterprise receives: overloadCard.

	delorean := Spaceship called: 'Delorean'.
	aBoard := Board
		          of: 10
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          byMany: { 
				          enterprise.
				          delorean }
		          with: { Box with: NoEffect new }.
	aBoard moveSpaceship: 3.
	aBoard moveSpaceship: 4.
	self assert: (aBoard positionOf: 'Enterprise') equals: 3.
	self assert: (aBoard positionOf: 'Delorean') equals: 4.
	enterprise throw: 1 to: 'Delorean' in: aBoard.
	aBoard moveSpaceship: 2.
	aBoard moveSpaceship: 1.
	self assert: (aBoard positionOf: 'Enterprise') equals: 5.
	self assert: (aBoard positionOf: 'Delorean') equals: 3
]

{ #category : #tests }
CardTest >> testOverloadCardReducesInTwoTheSpaceshipDiceThrow [
	| overloadCard enterprise aBoard delorean |
	overloadCard := OverloadCard  asA: PermanentCard new.

	enterprise := Spaceship called: 'Enterprise'.
	enterprise receives: overloadCard.

	delorean := Spaceship called: 'Delorean'.
	aBoard := Board
		          of: 10
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          byMany: { 
				          enterprise.
				          delorean }
		          with: { Box with: NoEffect new }.
	enterprise throw: 1 to: 'Delorean' in: aBoard.
	aBoard moveSpaceship: 3.
	aBoard moveSpaceship: 4.
	self assert: (aBoard positionOf: 'Enterprise') equals: 3.
	self assert: (aBoard positionOf: 'Delorean') equals: 2
]

{ #category : #tests }
CardTest >> testSpeedupCardIncreasesInOneTheSpaceshipDiceThrow [

	| speedCard enterprise aBoard delorean |
	speedCard := SpeedCard asA: PermanentCard new.

	enterprise := Spaceship called: 'Enterprise'.
	enterprise receives: speedCard.

	delorean := Spaceship called: 'Delorean'.
	aBoard := Board
		          of: 10
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          byMany: { 
				          enterprise.
				          delorean }
		          with: { (Box with: NoEffect new) }.
	enterprise throw: 1 to: 'Delorean' in: aBoard.
	aBoard moveSpaceship: 3.
	aBoard moveSpaceship: 4.
	self assert: (aBoard positionOf: 'Enterprise') equals: 3.
	self assert: (aBoard positionOf: 'Delorean') equals: 5
]

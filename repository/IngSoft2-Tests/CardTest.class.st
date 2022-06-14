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
CardTest >> testSpeedupCardincreasesInOneTheSpaceshipDiceThrow [
	| speedCard enterprise aBoard delorean |
	speedCard := SpeedCard  asA: PermanentCard new.

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
	aBoard moveSpaceship: 3.
	aBoard moveSpaceship: 4.
	self assert: (aBoard positionOf: 'Enterprise') equals: 3.
	self assert: (aBoard positionOf: 'Delorean') equals: 5
]
Class {
	#name : #SpaceshipHoldingCardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
SpaceshipHoldingCardTest >> testSpaceshipThatStartsWithTwoCardsAndPlaysOneHasOneCardLeftToPlay [

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
		                     using: aCardDistribution for: 100.

	self assert: (anOutstandingGame deckOf: 'Enterprise') size equals: 2.

	anOutstandingGame
		throws: (OverloadCard identifiedAs: '1' thrownAt: 'Delorean')
		from: 'Enterprise'.

	self assert: (anOutstandingGame deckOf: 'Enterprise') size equals: 1
]

Class {
	#name : #SpaceshipCardHolderTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
SpaceshipCardHolderTest >> testSpaceshipThatStartsWithTwoCardsAndPlaysOneHasOneCardLeftToPlay [

	| aBoard aCardDistribution anOutstandingGame aFiniteDeck |
	aBoard := Board
		          of: 10
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          with: { (Box with: NoEffect new) }.

	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: OverloadCard).
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

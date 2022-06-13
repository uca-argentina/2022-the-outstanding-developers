Class {
	#name : #CardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
CardTest >> testASpaceshipThrowsACardToAnotherOneAndItBecomesPartOfTheGame [

	| speedCard enterprise aBoard delorean collectionOfCards |
	speedCard := SpeedCard new.

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
		          with: { NoEffect new }.
	enterprise throw: 1 to: delorean in: aBoard.

	collectionOfCards := OrderedCollection new.
	collectionOfCards add: speedCard.
	self assert: (aBoard cardDeckOf: delorean) equals: collectionOfCards
]

{ #category : #tests }
CardTest >> testOverloadCardReducesInTwoTheSpaceshipDiceThrow [

]

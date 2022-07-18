Class {
	#name : #SpaceshipHoldingACard,
	#superclass : #Object,
	#instVars : [
		'spaceship',
		'card'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SpaceshipHoldingACard class >> of: aSpaceship holding: aCard [

	^ self new of: aSpaceship holding: aCard
]

{ #category : #accessing }
SpaceshipHoldingACard >> card [

	^ card
]

{ #category : #effect }
SpaceshipHoldingACard >> effectOnThrowWith: cardsAffecting and: usedCardsAffecting [

	| effect |
	effect := card effectOnThrow.
	cardsAffecting do: [ :cardAffecting | 
		(cardAffecting targetCard name = card name and: [ 
			 cardAffecting targetSpaceship = spaceship and: [ 
				 (usedCardsAffecting indexOf: cardAffecting) = 0 ] ]) ifTrue: [ 
			effect := cardAffecting effectOnThrow: effect.
			usedCardsAffecting add: cardAffecting ] ].
	^ effect
]

{ #category : #initialization }
SpaceshipHoldingACard >> of: aSpaceship holding: aCard [

	spaceship := aSpaceship.
	card := aCard
]

{ #category : #accessing }
SpaceshipHoldingACard >> spaceship [

	^ spaceship
]

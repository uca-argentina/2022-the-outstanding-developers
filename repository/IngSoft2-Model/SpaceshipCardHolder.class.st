Class {
	#name : #SpaceshipCardHolder,
	#superclass : #Object,
	#instVars : [
		'spaceship',
		'card'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SpaceshipCardHolder class >> of: aSpaceship holding: aCard [

	^ self new of: aSpaceship holding: aCard
]

{ #category : #accessing }
SpaceshipCardHolder >> card [

	^ card
]

{ #category : #'as yet unclassified' }
SpaceshipCardHolder >> effectOnThrowWith: cardsAffecting and: usedCardsAffecting [

	| cardAffectingCurrent cardAffectingFound effect |
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
SpaceshipCardHolder >> of: aSpaceship holding: aCard [

	spaceship := aSpaceship.
	card := aCard
]

{ #category : #accessing }
SpaceshipCardHolder >> spaceship [

	^ spaceship
]

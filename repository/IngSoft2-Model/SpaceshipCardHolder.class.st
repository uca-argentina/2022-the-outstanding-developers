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

	| cardAffectingCurrent cardAffectingFound |
	cardAffectingCurrent := cardsAffecting findFirst: [ :cardAffecting | 
		                        cardAffecting targetCard name = card name 
			                        and: [ 
			                        cardAffecting targetSpaceship = spaceship ] ].
	cardAffectingFound := cardsAffecting at: cardAffectingCurrent.
	(cardAffectingCurrent ~= 0 and: [ 
		 (usedCardsAffecting indexOf: cardAffectingFound) = 0 ]) ifTrue: [ 
		usedCardsAffecting add: cardAffectingFound.
		^ (cardsAffecting at: cardAffectingCurrent) effectOnThrow:
			  card effectOnThrow ].
	^ card effectOnThrow
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

Class {
	#name : #SpaceshipCardHolder,
	#superclass : #Object,
	#instVars : [
		'spaceship',
		'cardDeck',
		'card'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SpaceshipCardHolder class >> of: aSpaceship holding: aCard [

	^ self new of: aSpaceship holding: aCard
]

{ #category : #'card deck modifying' }
SpaceshipCardHolder >> add: aCard [

	cardDeck add: aCard
]

{ #category : #accessing }
SpaceshipCardHolder >> cardDeck [

	^ cardDeck 
]

{ #category : #accessing }
SpaceshipCardHolder >> effectOnThrow [

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

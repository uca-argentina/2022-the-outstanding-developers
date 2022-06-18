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

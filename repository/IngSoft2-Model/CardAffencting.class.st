Class {
	#name : #CardAffencting,
	#superclass : #Object,
	#instVars : [
		'card',
		'spaceShipCardHolder'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardAffencting class >> from: aCard to: aSpaceshipCardHolder [

	^ self new initializeFrom: aCard to: aSpaceshipCardHolder
]

{ #category : #playing }
CardAffencting >> effectOnThrow: anEffectOnAThrow [

	^ card affecting: anEffectOnAThrow 
]

{ #category : #initialzation }
CardAffencting >> initializeFrom: aCard to: aSpaceshipCardHolder [

	card := aCard.
	spaceShipCardHolder := aSpaceshipCardHolder
]

{ #category : #accessing }
CardAffencting >> targetCard [
	^ spaceShipCardHolder card
]

{ #category : #accessing }
CardAffencting >> targetSpaceship [

	^ spaceShipCardHolder spaceship
]

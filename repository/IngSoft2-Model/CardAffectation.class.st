Class {
	#name : #CardAffectation,
	#superclass : #Object,
	#instVars : [
		'card',
		'spaceShipCardHolder'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardAffectation class >> from: aCard to: aSpaceshipCardHolder [

	^ self new initializeFrom: aCard to: aSpaceshipCardHolder
]

{ #category : #playing }
CardAffectation >> effectOnThrow: anEffectOnAThrow [

	^ card affecting: anEffectOnAThrow 
]

{ #category : #initialzation }
CardAffectation >> initializeFrom: aCard to: aSpaceshipCardHolder [

	card := aCard.
	spaceShipCardHolder := aSpaceshipCardHolder
]

{ #category : #accessing }
CardAffectation >> targetCard [

	^ spaceShipCardHolder card
]

{ #category : #accessing }
CardAffectation >> targetSpaceship [

	^ spaceShipCardHolder spaceship
]

Class {
	#name : #CardAffectation,
	#superclass : #Object,
	#instVars : [
		'card',
		'spaceshipHoldingACard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardAffectation class >> from: aCard to: aSpaceshipHoldingACard [

	^ self new initializeFrom: aCard to: aSpaceshipHoldingACard
]

{ #category : #playing }
CardAffectation >> effectOn: aThrow [

	^ card affecting: aThrow
]

{ #category : #initialzation }
CardAffectation >> initializeFrom: aCard to: aSpaceshipHoldingACard [

	card := aCard.
	spaceshipHoldingACard := aSpaceshipHoldingACard
]

{ #category : #accessing }
CardAffectation >> targetCard [

	^ spaceshipHoldingACard card
]

{ #category : #accessing }
CardAffectation >> targetSpaceship [

	^ spaceshipHoldingACard spaceship
]

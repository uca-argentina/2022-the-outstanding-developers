Class {
	#name : #CardAwarderEffect,
	#superclass : #Object,
	#instVars : [
		'cardGenerator',
		'deck'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardAwarderEffect class >> create [

	^ self new
]

{ #category : #effects }
CardAwarderEffect >> applyEffectOn: aBoard [

	aBoard dealCard.
	^ self effectOnPosition
]

{ #category : #effects }
CardAwarderEffect >> applyEffectTo: aSpaceship on: aBoard [

	aBoard dealCardTo: aSpaceship.
	^ self effectOnPosition
]

{ #category : #effects }
CardAwarderEffect >> effectOnPosition [

	^ 0
]

{ #category : #effects }
CardAwarderEffect >> reApplyEffectTo: aSpaceship on: aBoard [

	aBoard
		movePlayingSpaceshipAt: (aBoard positionOf: aSpaceship)
		by: (self applyEffectTo: aSpaceship on: aBoard)
]

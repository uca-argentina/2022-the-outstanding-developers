Class {
	#name : #CardGiverEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardGiverEffect class >> create [

	^ self new
]

{ #category : #effects }
CardGiverEffect >> applyEffectOn: aBoard [

	aBoard dealCard.
	^ self effectOnPosition
]

{ #category : #effects }
CardGiverEffect >> applyEffectTo: aSpaceship on: aBoard [

	aBoard dealCardTo: aSpaceship.
	^ self effectOnPosition
]

{ #category : #effects }
CardGiverEffect >> effectOnPosition [

	^ 0
]

{ #category : #effects }
CardGiverEffect >> reApplyEffectTo: aSpaceship on: aBoard [

	aBoard
		move: aSpaceship
		atItsCurrentPositionBy: (self applyEffectTo: aSpaceship on: aBoard)
]

Class {
	#name : #NoEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
NoEffect class >> create [

	^ self new
]

{ #category : #effects }
NoEffect >> applyEffectOn: aBoard [

	^ self effectOnPosition
]

{ #category : #effects }
NoEffect >> applyEffectTo: aSpaceship on: aBoard [

	^ self applyEffectOn: aBoard
]

{ #category : #effect }
NoEffect >> effectOnPosition [

	^ 0
]

{ #category : #effects }
NoEffect >> reApplyEffectTo: aSpaceship on: aBoard [

	aBoard
		movePlayingSpaceshipAt: (aBoard positionOf: aSpaceship)
		by: (self applyEffectTo: aSpaceship on: aBoard)
]

{ #category : #accessing }
NoEffect >> typeOfEffect [

	^ 'No Effect'
]

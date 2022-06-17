Class {
	#name : #WormHoleEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
WormHoleEffect class >> create [

	^ self new
]

{ #category : #effects }
WormHoleEffect >> applyEffectOn: aBoard [

	^ self effectOnPosition
]

{ #category : #effects }
WormHoleEffect >> applyEffectTo: aSpaceship on: aBoard [

	^ self applyEffectOn: aBoard
]

{ #category : #effects }
WormHoleEffect >> effectOnPosition [

	^ -4
]

{ #category : #effects }
WormHoleEffect >> reApplyEffectTo: aSpaceship on: aBoard [ 

	aBoard 
		movePlayingSpaceshipAt: (aBoard positionOf: aSpaceship)
		by: (self applyEffectTo: aSpaceship on: aBoard).
]

{ #category : #accesing }
WormHoleEffect >> typeOfEffect [
	^'wormhole'
]

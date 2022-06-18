Class {
	#name : #SpeedUpEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SpeedUpEffect class >> create [

	^ self new
]

{ #category : #effects }
SpeedUpEffect >> applyEffectOn: aBoard [

	^ self effectOnPosition
]

{ #category : #effects }
SpeedUpEffect >> applyEffectTo: aSpaceship on: aBoard [

	^ self applyEffectOn: aBoard
]

{ #category : #effects }
SpeedUpEffect >> effectOnPosition [

	^ 4
]

{ #category : #effects }
SpeedUpEffect >> reApplyEffectTo: aSpaceship on: aBoard [ 

	aBoard 
		movePlayingSpaceshipAt: (aBoard positionOf: aSpaceship)
		by: (self applyEffectTo: aSpaceship on: aBoard).
]

{ #category : #accessing }
SpeedUpEffect >> typeOfEffect [

	^ 'Speedup'
]

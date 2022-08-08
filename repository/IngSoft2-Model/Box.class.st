Class {
	#name : #Box,
	#superclass : #Object,
	#instVars : [
		'effect'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Box class >> with: anEffect [

	^ self new with: anEffect
]

{ #category : #effects }
Box >> applyEffectOn: aBoard [

	^ effect applyEffectOn: aBoard
]

{ #category : #accessing }
Box >> effect [

	^ effect
]

{ #category : #effects }
Box >> effectOnPosition [

	^ effect effectOnPosition
]

{ #category : #accessing }
Box >> effectType [

	^ effect typeOfEffect
]

{ #category : #initialization }
Box >> with: anEffect [

	effect := anEffect
]

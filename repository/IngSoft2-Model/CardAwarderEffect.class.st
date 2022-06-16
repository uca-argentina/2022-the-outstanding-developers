Class {
	#name : #CardAwarderEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardAwarderEffect class >> create [

	^ self new
]

{ #category : #effects }
CardAwarderEffect >> applyEffectOn: aBoard [

	^ self effectOnPosition
]

{ #category : #effects }
CardAwarderEffect >> effectOnPosition [
	^ 0
]

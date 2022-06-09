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
WormHoleEffect >> effectOnPosition [

	^ -4
]

{ #category : #accesing }
WormHoleEffect >> typeOfEffect [
	^'wormhole'
]

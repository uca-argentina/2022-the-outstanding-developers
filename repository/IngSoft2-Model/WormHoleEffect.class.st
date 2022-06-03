Class {
	#name : #WormHoleEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
WormHoleEffect class >> create [

	^ self new
]

{ #category : #effect }
WormHoleEffect >> effectOnPosition [

	^ -4
]

{ #category : #effects }
WormHoleEffect >> effectOnPosition: aBoard [

	aBoard moveCurrentBy: self effectOnPosition
]

{ #category : #accesing }
WormHoleEffect >> typeOfEffect [
	^'wormhole'
]

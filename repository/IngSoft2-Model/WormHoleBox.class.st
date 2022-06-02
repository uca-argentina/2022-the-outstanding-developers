Class {
	#name : #WormHoleBox,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
WormHoleBox class >> create [

	^ self new
]

{ #category : #effect }
WormHoleBox >> effectOnPosition [

	^ -4
]

{ #category : #effects }
WormHoleBox >> effectOnPosition: aBoard [

	aBoard moveCurrentBy: self effectOnPosition
]

{ #category : #accesing }
WormHoleBox >> typeOfEffect [
	^'wormhole'
]

Class {
	#name : #WormHoleBox,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
WormHoleBox >> effectOnPosition [

	^ -4
]

{ #category : #effects }
WormHoleBox >> effectOnPosition: aBoard [

	aBoard moveCurrentBy: self effectOnPosition
]

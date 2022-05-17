Class {
	#name : #SpeedUpBox,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
SpeedUpBox >> effectOnPosition [

	^ 4
]

{ #category : #effects }
SpeedUpBox >> effectOnPosition: aBoard [

	aBoard moveCurrentBy: self effectOnPosition
]

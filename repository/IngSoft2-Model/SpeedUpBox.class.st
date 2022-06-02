Class {
	#name : #SpeedUpBox,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SpeedUpBox class >> create [
	^self new
]

{ #category : #effect }
SpeedUpBox >> effectOnPosition [

	^ 4
]

{ #category : #effects }
SpeedUpBox >> effectOnPosition: aBoard [

	aBoard moveCurrentBy: self effectOnPosition
]

{ #category : #accessing }
SpeedUpBox >> typeOfEffect [
	^'speedup'
]

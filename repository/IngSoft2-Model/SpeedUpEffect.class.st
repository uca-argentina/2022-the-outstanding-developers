Class {
	#name : #SpeedUpEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SpeedUpEffect class >> create [
	^self new
]

{ #category : #effect }
SpeedUpEffect >> effectOnPosition [

	^ 4
]

{ #category : #effects }
SpeedUpEffect >> effectOnPosition: aBoard [

	aBoard moveCurrentBy: self effectOnPosition
]

{ #category : #accessing }
SpeedUpEffect >> typeOfEffect [
	^'speedup'
]

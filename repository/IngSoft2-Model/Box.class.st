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
	
	^self new with: anEffect
]

{ #category : #effects }
Box >> effectOnPosition [

	^ effect effectOnPosition
]

{ #category : #effects }
Box >> effectOnPosition: aBoard [

	effect effectOnPosition: aBoard
]

{ #category : #accessing }
Box >> effectType [
	^effect typeOfEffect
]

{ #category : #initialization }
Box >> with: anEffect [

	effect := anEffect
]

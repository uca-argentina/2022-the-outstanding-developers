Class {
	#name : #Box,
	#superclass : #Object,
	#instVars : [
		'effect'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Box class >> withEffect: anEffect [ 
	
	^self new withEffect: anEffect
]

{ #category : #effects }
Box >> effectOnPosition [

	^ effect effectOnPosition
]

{ #category : #effects }
Box >> effectOnPosition: aBoard [

	effect effectOnPosition: aBoard
]

{ #category : #initialization }
Box >> withEffect: anEffect [

	effect := anEffect
]

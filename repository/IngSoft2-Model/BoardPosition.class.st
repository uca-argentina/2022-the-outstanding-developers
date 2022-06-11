Class {
	#name : #BoardPosition,
	#superclass : #Object,
	#instVars : [
		'position',
		'lap'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
BoardPosition class >> at: aPosition in: aLap [

	| validatedPosition validatedLap |
	validatedPosition := ((aPosition = 0 and: [ aLap > 1 ]) or:
		                      aPosition < 0)
		                     ifTrue: [ 1 ]
		                     ifFalse: [ aPosition ].
	validatedLap := aLap < 1
		                ifTrue: [ 1 ]
		                ifFalse: [ aLap ].
	^ self new initializeAt: validatedPosition in: validatedLap
]

{ #category : #comparing }
BoardPosition >> > aBoardPosition [

	lap > aBoardPosition lap ifFalse: [ 
		^ lap = aBoardPosition lap and: [ 
			  position > aBoardPosition position ] ].
	^ true
]

{ #category : #accessing }
BoardPosition >> initializeAt: aPosition in: aLap [

	position := aPosition.
	lap := aLap
]

{ #category : #accessing }
BoardPosition >> lap [
	^ lap
]

{ #category : #accessing }
BoardPosition >> position [
	^ position
]

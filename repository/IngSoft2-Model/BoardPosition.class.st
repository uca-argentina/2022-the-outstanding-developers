Class {
	#name : #BoardPosition,
	#superclass : #Object,
	#instVars : [
		'player',
		'position'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
BoardPosition class >> with: player [ 
	^self new initializeWith: player
]

{ #category : #initialization }
BoardPosition >> initializeWith: aPlayer [ 
	player := aPlayer.
	position := 0.
]

{ #category : #actions }
BoardPosition >> move: aNumberOfBoxes [ 
	position := position + aNumberOfBoxes 
]

{ #category : #accessing }
BoardPosition >> player [
	^ player
]

{ #category : #accessing }
BoardPosition >> position [
	^ position
]

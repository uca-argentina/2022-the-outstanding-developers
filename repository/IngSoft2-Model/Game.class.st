Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'board'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Game class >> with: aBoard [ 
	^self new initializeWith: aBoard.
]

{ #category : #initialization }
Game >> initializeWith: aBoard [ 
	board := aBoard.
]

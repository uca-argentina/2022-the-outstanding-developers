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

{ #category : #assertions }
BoardPosition >> assertValid: aNumberOfBoxes [
	(aNumberOfBoxes > 0) ifFalse: [ Error signal: 'Spaceship cant move backwards in the board'].
]

{ #category : #initialization }
BoardPosition >> initializeWith: aPlayer [ 
	player := aPlayer.
	position := 0.
]

{ #category : #actions }
BoardPosition >> move: aNumberOfBoxesToMove [
	self assertValid: aNumberOfBoxesToMove.
	position := position + aNumberOfBoxesToMove
]

{ #category : #accessing }
BoardPosition >> player [
	^ player
]

{ #category : #accessing }
BoardPosition >> position [
	^ position
]

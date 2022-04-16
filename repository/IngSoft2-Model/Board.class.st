Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'boxes'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Board class >> assertValid: boxes [
	boxes > 0 ifFalse: [ Error signal: 'Number of boxes should be greater than zero' ]
]

{ #category : #'instance creation' }
Board class >> with: aNumberOfBoxes [ 
	self assertValid: aNumberOfBoxes.
	^self new initializeWith: aNumberOfBoxes
]

{ #category : #initialization }
Board >> initializeWith: aNumberOfboxes [ 
	boxes := aNumberOfboxes 
]

{ #category : #properties }
Board >> lastPosition [
	^boxes 
]

{ #category : #movement }
Board >> moveForward: nBoxes the: aSpaceship [
	^nBoxes.
]

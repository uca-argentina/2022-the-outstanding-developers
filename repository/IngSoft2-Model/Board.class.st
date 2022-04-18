Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'boxes',
		'spaceshipsInTheBoard'
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

{ #category : #'instance creation' }
Board class >> withBoxes: aNumberOfBoxes andSpaceships: someSpaceships [ 
	self assertValid: aNumberOfBoxes.
	^self new initializeWithBoxes: aNumberOfBoxes initializeWithSpaceships: someSpaceships.
]

{ #category : #initialization }
Board >> initializeWith: aNumberOfboxes [ 
	boxes := aNumberOfboxes 
]

{ #category : #initialization }
Board >> initializeWithBoxes: aNumberOfBoxes initializeWithSpaceships: someSpaceships [ 
	boxes := aNumberOfBoxes.
	spaceshipsInTheBoard := someSpaceships.
]

{ #category : #properties }
Board >> isThereAWinner [
	| positionOfTheSpaceships |
	positionOfTheSpaceships := spaceshipsInTheBoard position.
	(positionOfTheSpaceships >= boxes)
	ifTrue: [ ^true ]
	ifFalse: [ ^false ]
	
]

{ #category : #properties }
Board >> lastPosition [
	^boxes 
]

{ #category : #movement }
Board >> moveForward: nBoxes the: aSpaceship [
	^nBoxes.
]

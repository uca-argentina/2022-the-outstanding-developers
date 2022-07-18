Class {
	#name : #Die,
	#superclass : #Object,
	#instVars : [
		'numberOfSides'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Die class >> assertValid: numberOfSides [

	numberOfSides < 3 ifTrue: [ 
		Error signal: 'Number of faces should be greater than 2' ]
]

{ #category : #'instance creation' }
Die class >> with: numberOfSides [

	self assertValid: numberOfSides.
	^ self new initializeWith: numberOfSides
]

{ #category : #initialization }
Die >> initializeWith: aNumberOfSides [

	numberOfSides := aNumberOfSides
]

{ #category : #rolling }
Die >> roll [

	^ numberOfSides atRandom
]

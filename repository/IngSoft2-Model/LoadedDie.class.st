Class {
	#name : #LoadedDie,
	#superclass : #Object,
	#instVars : [
		'result',
		'sequence',
		'currentPosition'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
LoadedDie class >> assertValid: aSequence [
	
	(aSequence allSatisfy: [ :number | number > 0 ]) ifFalse: [ Error signal: 'Die should be loaded with numbers greater than zero' ]
]

{ #category : #'instance creation' }
LoadedDie class >> with: result [
	^self withSequence: {result}.
]

{ #category : #'instance creation' }
LoadedDie class >> withSequence: aSequence [
	self assertValid: aSequence.
	^self new initializeWithASequence: aSequence.
]

{ #category : #initialization }
LoadedDie >> initializeWithASequence: aSequence [
	sequence := aSequence.
	currentPosition := 1.
]

{ #category : #rolling }
LoadedDie >> roll [
	
	| currentNumberBANANA |
	currentNumberBANANA := sequence at: currentPosition.
	currentPosition := (currentPosition rem: sequence size) + 1.
	^currentNumberBANANA.
]

Class {
	#name : #LoadedDie,
	#superclass : #Object,
	#instVars : [
		'sequence',
		'sequenceHandler'
	],
	#category : #'IngSoft2-Tests'
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
	sequenceHandler := SequenceHandler for: aSequence size
]

{ #category : #rolling }
LoadedDie >> roll [

	^ sequence at: sequenceHandler index
]

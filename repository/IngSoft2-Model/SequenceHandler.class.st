Class {
	#name : #SequenceHandler,
	#superclass : #Object,
	#instVars : [
		'sequenceSize',
		'currentSequenceIndex',
		'sequenceValueInUse'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SequenceHandler class >> for: aSequenceSize [

	^ self new initializeFor: aSequenceSize
]

{ #category : #assertion }
SequenceHandler >> assertSequenceIndexIs: anIndex [

	^ anIndex = sequenceValueInUse
]

{ #category : #accessing }
SequenceHandler >> currentIndex [

	^ sequenceValueInUse
]

{ #category : #initialization }
SequenceHandler >> initializeFor: aSequenceSize [

	sequenceSize := aSequenceSize.
	currentSequenceIndex := 1.
	sequenceValueInUse := 1
]

{ #category : #turns }
SequenceHandler >> nextValue [

	sequenceValueInUse := currentSequenceIndex.
	currentSequenceIndex := (currentSequenceIndex rem: sequenceSize) + 1.
	^ sequenceValueInUse
]

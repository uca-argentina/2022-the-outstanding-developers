Class {
	#name : #SequenceHandler,
	#superclass : #Object,
	#instVars : [
		'sequenceSize',
		'currentSequenceIndex',
		'beingUsedNow'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SequenceHandler class >> for: aSequenceSize [

	^ self new initializeFor: aSequenceSize
]

{ #category : #assertion }
SequenceHandler >> assertSequenceIndexIs: anIndex [

	^ anIndex = beingUsedNow
]

{ #category : #accessing }
SequenceHandler >> currentIndex [

	^ beingUsedNow
]

{ #category : #turns }
SequenceHandler >> index [

	beingUsedNow := currentSequenceIndex.
	currentSequenceIndex := (currentSequenceIndex rem: sequenceSize) + 1.
	^ beingUsedNow
]

{ #category : #initialization }
SequenceHandler >> initializeFor: aSequenceSize [

	sequenceSize := aSequenceSize.
	currentSequenceIndex := 1.
	beingUsedNow := 1
]

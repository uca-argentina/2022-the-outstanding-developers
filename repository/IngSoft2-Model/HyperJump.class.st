Class {
	#name : #HyperJump,
	#superclass : #Object,
	#instVars : [
		'parsecs',
		'parsecsValuesHandler'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
HyperJump class >> randomlyOf: aParsecSequenceSize upTo: aBoxAmount [

	^ self new randomlyOf: aParsecSequenceSize upTo: aBoxAmount
]

{ #category : #'instance creation' }
HyperJump class >> with: parsecsValues [ 
	^self new with: parsecsValues.
]

{ #category : #assertion }
HyperJump >> assertSequenceSizeIsValid: aParsecSequenceSize [

	aParsecSequenceSize > 0 ifFalse: [ 
		Error signal: 'Parsec sequence size must be greater than zero' ]
]

{ #category : #effect }
HyperJump >> effectOnPosition [

	^ parsecs at: parsecsValuesHandler index
]

{ #category : #effects }
HyperJump >> effectOnPosition: aBoard [

	| aNumberOfBoxes |
	aNumberOfBoxes := (self effectOnPosition / aBoard boxLength) floor.
	aBoard moveCurrentBy: aNumberOfBoxes
]

{ #category : #initialization }
HyperJump >> randomlyOf: aParsecSequenceSize upTo: aBoxAmount [
	
	self assertSequenceSizeIsValid: aParsecSequenceSize.
	parsecs := OrderedCollection new.
	aParsecSequenceSize timesRepeat: [ 
		parsecs add: (1 to: aBoxAmount) atRandom ].
	parsecs sort: [ :parsecValue1 :parsecValue2 | 
		parsecValue1 > parsecValue2 ].
	parsecsValuesHandler := SequenceHandler for: parsecs size
]

{ #category : #accessing }
HyperJump >> typeOfEffect [
	^'hyperjump'
]

{ #category : #initialization }
HyperJump >> with: parsecsValues [

	parsecs := parsecsValues.
	parsecsValuesHandler := SequenceHandler for: parsecs size
]

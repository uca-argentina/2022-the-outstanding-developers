Class {
	#name : #HyperJumpEffect,
	#superclass : #Object,
	#instVars : [
		'parsecs',
		'parsecsValuesHandler'
	],
	#classInstVars : [
		'numberOfBoxes',
		'limit'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
HyperJumpEffect class >> create [

	| r |
	r := Random new.
	^ self randomlyOf: (r next * (numberOfBoxes - 1) + 1) floor upTo: limit
]

{ #category : #'class initialization' }
HyperJumpEffect class >> for: aNumberOfBoxes upTo: aLimit [

	numberOfBoxes := aNumberOfBoxes.
	limit := aLimit
]

{ #category : #'instance creation' }
HyperJumpEffect class >> randomlyOf: aParsecSequenceSize upTo: aBoxAmount [

	^ self new randomlyOf: aParsecSequenceSize upTo: aBoxAmount
]

{ #category : #'instance creation' }
HyperJumpEffect class >> with: parsecsValues [ 
	^self new with: parsecsValues.
]

{ #category : #assertion }
HyperJumpEffect >> assertBoxAmountIsValid: aBoxAmount [ 
	aBoxAmount  > 0 ifFalse: [ 
		Error signal: 'There must be an amount of at least one Box' ]
]

{ #category : #assertion }
HyperJumpEffect >> assertSequenceSizeIsValid: aParsecSequenceSize [

	aParsecSequenceSize > 0 ifFalse: [ 
		Error signal: 'Parsec sequence size must be greater than zero' ]
]

{ #category : #effect }
HyperJumpEffect >> effectOnPosition [

	^ parsecs at: parsecsValuesHandler index
]

{ #category : #effects }
HyperJumpEffect >> effectOnPosition: aBoard [

	| aNumberOfBoxes |
	aNumberOfBoxes := (self effectOnPosition / aBoard boxLength) floor.
	aBoard moveCurrentBy: aNumberOfBoxes
]

{ #category : #initialization }
HyperJumpEffect >> randomlyOf: aParsecSequenceSize upTo: aBoxAmount [
	
	self assertSequenceSizeIsValid: aParsecSequenceSize.
	self assertBoxAmountIsValid: aBoxAmount.
	parsecs := OrderedCollection new.
	aParsecSequenceSize timesRepeat: [ 
		parsecs add: (1 to: aBoxAmount) atRandom ].
	parsecs sort: [ :parsecValue1 :parsecValue2 | 
		parsecValue1 > parsecValue2 ].
	parsecsValuesHandler := SequenceHandler for: parsecs size
]

{ #category : #accessing }
HyperJumpEffect >> typeOfEffect [
	^'hyperjump'
]

{ #category : #initialization }
HyperJumpEffect >> with: parsecsValues [

	parsecs := parsecsValues.
	parsecsValuesHandler := SequenceHandler for: parsecs size
]

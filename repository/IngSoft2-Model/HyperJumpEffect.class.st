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

	| random |
	random := Random new.
	^ self randomlyOf: (random next * (numberOfBoxes - 1) + 1) floor
]

{ #category : #'class initialization' }
HyperJumpEffect class >> for: aNumberOfBoxes upTo: aLimit [

	numberOfBoxes := aNumberOfBoxes.
	limit := aLimit
]

{ #category : #'instance creation' }
HyperJumpEffect class >> randomlyOf: aParsecSequenceSize [

	^ self new randomlyOf: aParsecSequenceSize
]

{ #category : #'instance creation' }
HyperJumpEffect class >> with: parsecsValues [ 
	^self new with: parsecsValues.
]

{ #category : #effects }
HyperJumpEffect >> applyEffectOn: aBoard [

	| aNumberOfBoxes |
	aNumberOfBoxes := (self effectOnPosition / aBoard boxParsecLength) floor.
	^ aNumberOfBoxes
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

	^ parsecs at: parsecsValuesHandler nextValue
]

{ #category : #initialization }
HyperJumpEffect >> randomlyOf: aParsecSequenceSize [

	| random |
	self assertSequenceSizeIsValid: aParsecSequenceSize.
	random := Random new.
	parsecs := OrderedCollection new.
	aParsecSequenceSize timesRepeat: [ 
		parsecs add: random next / random next ].
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

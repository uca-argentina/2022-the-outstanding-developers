Class {
	#name : #HyperJumpEffect,
	#superclass : #Object,
	#instVars : [
		'parsecs',
		'parsecsValuesHandler',
		'sequenceUnits'
	],
	#classInstVars : [
		'numberOfBoxes',
		'limit'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
HyperJumpEffect class >> createFrom: aMeasurementUnit [

	| random |
	random := Random new.
	^ self
		  randomlyOf: (random next * (numberOfBoxes - 1) + 1) floor
		  and: aMeasurementUnit
]

{ #category : #'class initialization' }
HyperJumpEffect class >> for: aNumberOfBoxes upTo: aLimit [

	numberOfBoxes := aNumberOfBoxes.
	limit := aLimit
]

{ #category : #'instance creation' }
HyperJumpEffect class >> randomlyOf: aSequenceSize and: aMeasurementUnit [

	^ self new randomlyOf: aSequenceSize and: aMeasurementUnit 
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
HyperJumpEffect >> assertSequenceSizeIsValid: aParsecSequenceSize [

	aParsecSequenceSize > 0 ifFalse: [ 
		Error signal: 'Parsec sequence size must be greater than zero' ]
]

{ #category : #effect }
HyperJumpEffect >> effectOnPosition [

	^ sequenceUnits at: parsecsValuesHandler nextValue
]

{ #category : #initialization }
HyperJumpEffect >> randomlyOf: aSequenceSize and: aMeasurementUnit [

	| random |
	self assertSequenceSizeIsValid: aSequenceSize.
	random := Random new.
	sequenceUnits := OrderedCollection new.
	aSequenceSize timesRepeat: [ 
		sequenceUnits add: (aMeasurementUnit of: random next / random next) ].
	sequenceUnits sort: [ :sequenceUnitValue1 :sequenceUnitValue2 | 
		sequenceUnitValue1 > sequenceUnitValue2 ].
	parsecsValuesHandler := SequenceHandler for: sequenceUnits size
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

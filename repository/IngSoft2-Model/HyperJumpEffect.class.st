Class {
	#name : #HyperJumpEffect,
	#superclass : #Object,
	#instVars : [
		'parsecsValuesHandler',
		'sequenceUnits'
	],
	#classInstVars : [
		'numberOfBoxes',
		'limit'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
HyperJumpEffect class >> assertMeasurementValuesAreNotEmpty: measurementValues [
	measurementValues size > 0 ifFalse: [ Error signal: 'Sequence size must be greater than zero' ]
]

{ #category : #'instance creation' }
HyperJumpEffect class >> create [
	| randomValue measurementUnit |
	randomValue := 2 atRandom. 
	measurementUnit := LightYearUnit.
	randomValue = 1 ifTrue: [ measurementUnit := ParsecUnit ].
	^self createFrom: measurementUnit
]

{ #category : #'instance creation' }
HyperJumpEffect class >> createFrom: aMeasurementUnit [

	| random |
	random := Random new.
	^ self new
		  randomlyOf: (random next / random next) ceiling
		  and: aMeasurementUnit
]

{ #category : #'instance creation' }
HyperJumpEffect class >> with: measurementValues [ 
	self assertMeasurementValuesAreNotEmpty: measurementValues.
	^self new with: measurementValues.
]

{ #category : #effects }
HyperJumpEffect >> applyEffectOn: aBoard [

	| aNumberOfBoxes |
	aNumberOfBoxes := ((self effectOnPosition / aBoard boardUnitLength) * aBoard amountOfBoxes) floor.
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
HyperJumpEffect >> with: measurementValues [

	sequenceUnits := measurementValues.
	parsecsValuesHandler := SequenceHandler for: sequenceUnits size
]

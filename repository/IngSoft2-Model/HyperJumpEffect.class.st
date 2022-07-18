Class {
	#name : #HyperJumpEffect,
	#superclass : #Object,
	#instVars : [
		'parsecsValuesHandler',
		'sequenceUnits'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
HyperJumpEffect class >> assertMeasurementValuesAreNotEmpty: measurementValues [

	measurementValues isEmpty ifTrue: [ 
		Error signal: 'Sequence size must be greater than zero' ]
]

{ #category : #'instance creation' }
HyperJumpEffect class >> create [

	| randomValue measurementUnit |
	randomValue := 2 atRandom.
	measurementUnit := LightYearUnit.
	randomValue = 1 ifTrue: [ measurementUnit := ParsecUnit ].
	^ self createFrom: measurementUnit
]

{ #category : #'instance creation' }
HyperJumpEffect class >> createFrom: aMeasurementUnit [

	| random sequenceSize sequenceUnits |
	random := Random new.
	sequenceSize := (random next / random next) ceiling.
	sequenceUnits := OrderedCollection new.
	sequenceSize timesRepeat: [ 
		sequenceUnits add: (aMeasurementUnit of: random next / random next) ].
	^ self with: sequenceUnits
]

{ #category : #'instance creation' }
HyperJumpEffect class >> with: measurementValues [

	self assertMeasurementValuesAreNotEmpty: measurementValues.
	^ self new with: measurementValues
]

{ #category : #effects }
HyperJumpEffect >> applyEffectOn: aBoard [

	^ (self effectOnPosition / aBoard boardUnitLength
	   * aBoard amountOfBoxes) floor
]

{ #category : #effects }
HyperJumpEffect >> effectOnPosition [

	^ sequenceUnits at: parsecsValuesHandler nextValue
]

{ #category : #accessing }
HyperJumpEffect >> typeOfEffect [

	^ 'HyperJump'
]

{ #category : #initialization }
HyperJumpEffect >> with: measurementValues [

	sequenceUnits := measurementValues.
	sequenceUnits sort: [ :sequenceUnitValue1 :sequenceUnitValue2 | 
		sequenceUnitValue1 > sequenceUnitValue2 ].
	parsecsValuesHandler := SequenceHandler for: sequenceUnits size
]

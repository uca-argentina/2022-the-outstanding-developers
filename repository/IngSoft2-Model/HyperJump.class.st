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
HyperJump class >> with: parsecsValues [ 
	^self new with: parsecsValues.
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

{ #category : #accessing }
HyperJump >> typeOfEffect [
	^'hyperjump'
]

{ #category : #initialization }
HyperJump >> with: parsecsValues [

	parsecs := parsecsValues.
	parsecsValuesHandler := SequenceHandler for: parsecs size
]

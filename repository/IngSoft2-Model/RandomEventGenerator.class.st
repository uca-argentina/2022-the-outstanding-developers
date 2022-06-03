Class {
	#name : #RandomEventGenerator,
	#superclass : #Object,
	#instVars : [
		'randomBoxes'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
RandomEventGenerator class >> with: aNumberOfBoxes using: aDistribution [ 
	^ self new initializeWith: aNumberOfBoxes using: aDistribution 
]

{ #category : #initialization }
RandomEventGenerator >> createFor: aNumberOfBoxes using: orderedDistribution with: random [

	aNumberOfBoxes timesRepeat: [ 
		| randomNumber index coveredProbabilities |
		coveredProbabilities := 0.
		index := 1.
		randomNumber := random next.
		[ randomNumber < ((orderedDistribution at: index) probability + coveredProbabilities) ] 
			whileFalse: [ 
				coveredProbabilities := coveredProbabilities + (orderedDistribution at: index) probability.
				index := index + 1 ].
		randomBoxes add:
			(orderedDistribution at: index) classAssociated create ]
]

{ #category : #accessing }
RandomEventGenerator >> generate [
	^randomBoxes 
]

{ #category : #initialization }
RandomEventGenerator >> initializeWith: aNumberOfBoxes using: aDistribution [

	| random anOrderedDistribution |
	random := Random new.
	anOrderedDistribution := aDistribution sort: [ 
		                       :probabilityA 
		                       :probabilityB | probabilityA < probabilityB ].
	randomBoxes := OrderedCollection new.
	self
		createFor: aNumberOfBoxes
		using: anOrderedDistribution
		with: random
]

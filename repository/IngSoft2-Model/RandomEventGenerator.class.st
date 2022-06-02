Class {
	#name : #RandomEventGenerator,
	#superclass : #Object,
	#instVars : [
		'randomBoxes'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
RandomEventGenerator class >> with: aNumberOfBoxes distributedWith: aDistribution [ 
	^ self new initializeWith: aNumberOfBoxes andDistributedWith: aDistribution 
]

{ #category : #accessing }
RandomEventGenerator >> generate [
	^randomBoxes 
]

{ #category : #initialization }
RandomEventGenerator >> initializeWith: aNumberOfBoxes andDistributedWith: aDistribution [

	| r orderedDistributions |
	r := Random new.
	orderedDistributions := aDistribution sort: [ 
		                        :probabilityA 
		                        :probabilityB | probabilityA < probabilityB ].
	randomBoxes := OrderedCollection new.
	aNumberOfBoxes timesRepeat: [ 
		| randomNumber i coveredProbabilities |
		coveredProbabilities := 0.
		i := 1.
		randomNumber := r next.
		[ 
		randomNumber
		< ((orderedDistributions at: i) probability + coveredProbabilities) ] 
			whileFalse: [ 
				coveredProbabilities := coveredProbabilities
				                        + (orderedDistributions at: i) probability.
				i := i + 1 ].
		randomBoxes add: (orderedDistributions at: i) classAssociated create ]
]

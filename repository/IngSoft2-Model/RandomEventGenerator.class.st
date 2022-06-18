Class {
	#name : #RandomEventGenerator,
	#superclass : #Object,
	#instVars : [
		'randomBoxes'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
RandomEventGenerator class >> assertProbabilitiesAddUpToOne: aDistribution [

	((aDistribution sum: [ :probabilityDistribution | 
		  probabilityDistribution probability ]) round: 2) = 1 ifFalse: [ 
		Error signal: 'Probabilities of the distribution must add up to one' ]
]

{ #category : #'instance creation' }
RandomEventGenerator class >> with: aNumberOfBoxes using: aDistribution [

	self assertProbabilitiesAddUpToOne: aDistribution.
	^ self new initializeWith: aNumberOfBoxes using: aDistribution
]

{ #category : #initialization }
RandomEventGenerator >> createFor: aNumberOfBoxes using: orderedDistribution [

	| random |
	random := Random new.
	aNumberOfBoxes timesRepeat: [ 
		| randomNumber index coveredProbabilities |
		coveredProbabilities := 0.
		index := 1.
		randomNumber := random next.
		[ 
		randomNumber
		<
		((orderedDistribution at: index) probability + coveredProbabilities) ] 
			whileFalse: [ 
				coveredProbabilities := coveredProbabilities
				                        +
				                        (orderedDistribution at: index)
					                        probability.
				index := index + 1 ].
		randomBoxes add:
			(orderedDistribution at: index) classAssociated create ]
]

{ #category : #accessing }
RandomEventGenerator >> generate [

	^ randomBoxes
]

{ #category : #initialization }
RandomEventGenerator >> initializeWith: aNumberOfBoxes using: aDistribution [

	randomBoxes := OrderedCollection new.
	self createFor: aNumberOfBoxes using: aDistribution
]

Class {
	#name : #RandomEventGenerator,
	#superclass : #Object,
	#instVars : [
		'randomEvents'
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
RandomEventGenerator class >> with: anAmount using: aDistribution [

	self assertProbabilitiesAddUpToOne: aDistribution.
	^ self new initializeWith: anAmount using: aDistribution
]

{ #category : #generation }
RandomEventGenerator >> createFor: aSequenceSize using: aDistribution [

	| random |
	random := Random new.
	aSequenceSize timesRepeat: [ 
		| randomNumber index coveredProbabilities |
		coveredProbabilities := 0.
		index := 1.
		randomNumber := random next.
		[ 
		randomNumber
		<
		((aDistribution at: index) probability + coveredProbabilities) ] 
			whileFalse: [ 
				coveredProbabilities := coveredProbabilities
				                        +
				                        (aDistribution at: index)
					                        probability.
				index := index + 1 ].
		randomEvents add:
			(aDistribution at: index) eventAssociated create ]
]

{ #category : #generation }
RandomEventGenerator >> generate [

	^ randomEvents
]

{ #category : #initialization }
RandomEventGenerator >> initializeWith: anAmount using: aDistribution [

	randomEvents := OrderedCollection new.
	self createFor: anAmount using: aDistribution
]

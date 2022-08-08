Class {
	#name : #Distribution,
	#superclass : #Object,
	#instVars : [
		'probability',
		'event'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Distribution class >> assertProbabilityIsBetweenZeroAndOne: aProbability [

	(aProbability between: 0 and: 1) ifFalse: [ 
		Error signal: 'Probabilities must be between zero and one' ]
]

{ #category : #'instance creation' }
Distribution class >> withProbabilityOf: aValue for: anEvent [

	self assertProbabilityIsBetweenZeroAndOne: aValue.
	^ self new initializeWithProbabilityOf: aValue for: anEvent
]

{ #category : #accessing }
Distribution >> eventAssociated [

	^ event
]

{ #category : #initialization }
Distribution >> initializeWithProbabilityOf: aValue for: anEvent [

	probability := aValue.
	event := anEvent
]

{ #category : #accessing }
Distribution >> probability [

	^ probability
]

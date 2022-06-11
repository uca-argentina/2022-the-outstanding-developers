Class {
	#name : #Distribution,
	#superclass : #Object,
	#instVars : [
		'probability',
		'class'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Distribution class >> assertProbabilityIsBetweenZeroAndOne: aProbability [

	(aProbability between: 0 and: 1) ifFalse: [ 
		Error signal: 'Probabilities must be between zero and one' ]
]

{ #category : #'instance creation' }
Distribution class >> withProbabilityOf: aValue for: aClass [

	self assertProbabilityIsBetweenZeroAndOne: aValue.
	^ self new initializeWithProbabilityOf: aValue for: aClass
]

{ #category : #accessing }
Distribution >> classAssociated [
	^class.
]

{ #category : #initialization }
Distribution >> initializeWithProbabilityOf: aValue for: aClass [

	probability := aValue.
	class := aClass
]

{ #category : #accessing }
Distribution >> probability [
	^ probability
]

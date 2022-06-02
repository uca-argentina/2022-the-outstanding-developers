Class {
	#name : #Distribution,
	#superclass : #Object,
	#instVars : [
		'probability',
		'class'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Distribution class >> withProbabilityOf: aValue for: aClass [

	^ self new initializeWithProbabilityOf: aValue for: aClass
]

{ #category : #comparing }
Distribution >> < aDistribution [

	^ self probability < aDistribution probability
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

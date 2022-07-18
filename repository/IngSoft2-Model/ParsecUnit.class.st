Class {
	#name : #ParsecUnit,
	#superclass : #Object,
	#instVars : [
		'parsecAmount'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #assertion }
ParsecUnit class >> assertValidAmountOf: parsecs [

	parsecs >= 0 ifFalse: [ 
		Error signal: 'Units cannot be negative' ]
]

{ #category : #'instance creation' }
ParsecUnit class >> of: anAmountOfParsecs [

	self assertValidAmountOf: anAmountOfParsecs.
	^ self new of: anAmountOfParsecs
]

{ #category : #operations }
ParsecUnit >> / aUnit [

	^ parsecAmount / aUnit inParsecs
]

{ #category : #comparing }
ParsecUnit >> > aUnit [

	^ parsecAmount > aUnit inParsecs
]

{ #category : #conversion }
ParsecUnit >> inLightYears [

	^ parsecAmount * 3
]

{ #category : #accessing }
ParsecUnit >> inParsecs [

	^ parsecAmount
]

{ #category : #initialization }
ParsecUnit >> of: anAmountOfParsecs [

	parsecAmount := anAmountOfParsecs
]

{ #category : #accessing }
ParsecUnit >> valueOfMeasurement [

	^ parsecAmount
]

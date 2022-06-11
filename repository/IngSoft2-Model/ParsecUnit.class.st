Class {
	#name : #ParsecUnit,
	#superclass : #Object,
	#instVars : [
		'parsecAmount'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #assertion }
ParsecUnit class >> assertValid: anAmountOfParsecs [ 
	
	anAmountOfParsecs >= 0 ifFalse: [ Error signal: 'Units cannot be negative' ]
]

{ #category : #'instance creation' }
ParsecUnit class >> of: anAmountOfParsecs [ 

	self assertValid: anAmountOfParsecs. 
	^self new of: anAmountOfParsecs.
]

{ #category : #comparing }
ParsecUnit >> > aParsecUnit [

	^ parsecAmount > aParsecUnit inParsecs
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

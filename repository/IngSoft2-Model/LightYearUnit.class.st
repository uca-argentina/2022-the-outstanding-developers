Class {
	#name : #LightYearUnit,
	#superclass : #Object,
	#instVars : [
		'lightYearsAmount'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #assertion }
LightYearUnit class >> assertValid: aLightYearsAmount [

	aLightYearsAmount >= 0 ifFalse: [ 
		Error signal: 'Units cannot be negative' ]
]

{ #category : #'instance creation' }
LightYearUnit class >> of: aLightYearsAmount [

	self assertValid: aLightYearsAmount.
	^ self new of: aLightYearsAmount
]

{ #category : #operations }
LightYearUnit >> / aUnit [

	^ lightYearsAmount / aUnit inLightYears
]

{ #category : #comparing }
LightYearUnit >> > aUnit [

	^ lightYearsAmount > aUnit inLightYears
]

{ #category : #accessing }
LightYearUnit >> inLightYears [

	^ lightYearsAmount
]

{ #category : #conversion }
LightYearUnit >> inParsecs [

	^ lightYearsAmount / 3
]

{ #category : #initialization }
LightYearUnit >> of: aLightYearsAmount [

	lightYearsAmount := aLightYearsAmount
]

{ #category : #accessing }
LightYearUnit >> valueOfMeasurement [

	^ lightYearsAmount
]

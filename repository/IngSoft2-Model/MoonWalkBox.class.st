Class {
	#name : #MoonWalkBox,
	#superclass : #Object,
	#instVars : [
		'displacement'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #assertion }
MoonWalkBox class >> assertValidDisplacement: anAmount [

	anAmount > 0 ifFalse: [ 
		Error signal: 'MoonWalkBox displacement should be greater than zero' ]
]

{ #category : #'instance creation' }
MoonWalkBox class >> displacing: aNumberOfBoxes [
	self assertValidDisplacement: aNumberOfBoxes.
	^ self new displacing: aNumberOfBoxes
]

{ #category : #initialization }
MoonWalkBox >> displacing: aNumberOfBoxes [

	displacement := aNumberOfBoxes
]

{ #category : #effect }
MoonWalkBox >> effectOnPosition [

	^ displacement * -1
]

{ #category : #effects }
MoonWalkBox >> effectOnPosition: aBoard [

	aBoard moveAllExceptCurrentBy: self effectOnPosition
]

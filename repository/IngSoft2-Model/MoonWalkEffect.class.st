Class {
	#name : #MoonWalkEffect,
	#superclass : #Object,
	#instVars : [
		'displacement'
	],
	#classInstVars : [
		'numberOfBoxes'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #assertion }
MoonWalkEffect class >> assertValidDisplacement: anAmount [

	anAmount > 0 ifFalse: [ 
		Error signal: 'MoonWalkBox displacement should be greater than zero' ]
]

{ #category : #'instance creation' }
MoonWalkEffect class >> create [

	^ self new displacing: numberOfBoxes atRandom
]

{ #category : #'instance creation' }
MoonWalkEffect class >> displacing: aNumberOfBoxes [
	self assertValidDisplacement: aNumberOfBoxes.
	^ self new displacing: aNumberOfBoxes
]

{ #category : #'class initialization' }
MoonWalkEffect class >> for: aNumberOfBoxes [ 
	 numberOfBoxes := aNumberOfBoxes 
]

{ #category : #effects }
MoonWalkEffect >> applyEffectOn: aBoard [

	aBoard moveAllExceptCurrentBy: self effectOnPosition.
	^ 0
]

{ #category : #initialization }
MoonWalkEffect >> displacing: aNumberOfBoxes [

	displacement := (-1 * aNumberOfBoxes)
]

{ #category : #effects }
MoonWalkEffect >> effectOnPosition [

	^ displacement
]

{ #category : #accessing }
MoonWalkEffect >> typeOfEffect [
	^'moonwalk'
]
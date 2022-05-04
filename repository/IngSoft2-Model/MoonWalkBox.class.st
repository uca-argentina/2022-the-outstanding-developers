Class {
	#name : #MoonWalkBox,
	#superclass : #Object,
	#instVars : [
		'displacement'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
MoonWalkBox class >> displacing: aNumberOfBoxes [

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

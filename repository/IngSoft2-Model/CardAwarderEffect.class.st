Class {
	#name : #CardAwarderEffect,
	#superclass : #Object,
	#instVars : [
		'deck',
		'cardGenerator'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardAwarderEffect class >> create [

	^ self new
]

{ #category : #'instance creation' }
CardAwarderEffect class >> with: aDistribution [

	| randomBoxGenerator |
	randomBoxGenerator := RandomEventGenerator
		                      with: 1
		                      using: aDistribution.
	^self new initializeWith: randomBoxGenerator
]

{ #category : #effects }
CardAwarderEffect >> applyEffectOn: aBoard [
	self dealCardIn: aBoard.
	^ self effectOnPosition
]

{ #category : #effect }
CardAwarderEffect >> dealCard [

	^ cardGenerator generate at: 1
]

{ #category : #effect }
CardAwarderEffect >> dealCardIn: aBoard [ 
	| card |
	card:= self dealCard.
	aBoard assignToCurrentSpaceship: card
]

{ #category : #effects }
CardAwarderEffect >> effectOnPosition [
	^ 0
]

{ #category : #initialization }
CardAwarderEffect >> initializeWith: aRandomEventGenerator [

	cardGenerator := aRandomEventGenerator
]

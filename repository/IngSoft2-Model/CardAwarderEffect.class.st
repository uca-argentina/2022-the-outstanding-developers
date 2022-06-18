Class {
	#name : #CardAwarderEffect,
	#superclass : #Object,
	#instVars : [
		'cardGenerator'
	],
	#classInstVars : [
		'randomCardGenerator'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardAwarderEffect class >> create [

	^ self new initializeWith: randomCardGenerator
]

{ #category : #'instance creation' }
CardAwarderEffect class >> with: aDistribution [

	randomCardGenerator := RandomEventGenerator
		                      with: 1
		                      using: aDistribution.
	^ self new initializeWith: randomCardGenerator
]

{ #category : #'instance creation' }
CardAwarderEffect class >> withA: distribution [

	randomCardGenerator := RandomEventGenerator
		                      with: 1
		                      using: distribution
]

{ #category : #effects }
CardAwarderEffect >> applyEffectOn: aBoard [

	self dealCardIn: aBoard.
	^ self effectOnPosition
]

{ #category : #effects }
CardAwarderEffect >> applyEffectTo: aSpaceship on: aBoard [

	self dealCardTo: aSpaceship in: aBoard.
	^ self effectOnPosition
]

{ #category : #effects }
CardAwarderEffect >> dealCard [

	^ cardGenerator generate at: 1
]

{ #category : #effects }
CardAwarderEffect >> dealCardIn: aBoard [

	| card |
	card := self dealCard.
	aBoard assignToCurrentSpaceship: card
]

{ #category : #effects }
CardAwarderEffect >> dealCardTo: aSpaceship in: aBoard [

	aBoard assign: self dealCard to: aSpaceship
]

{ #category : #effects }
CardAwarderEffect >> effectOnPosition [

	^ 0
]

{ #category : #initialization }
CardAwarderEffect >> initializeWith: aRandomEventGenerator [

	cardGenerator := aRandomEventGenerator
]

{ #category : #effects }
CardAwarderEffect >> reApplyEffectTo: aSpaceship on: aBoard [

	aBoard
		movePlayingSpaceshipAt: (aBoard positionOf: aSpaceship)
		by: (self applyEffectTo: aSpaceship on: aBoard)
]

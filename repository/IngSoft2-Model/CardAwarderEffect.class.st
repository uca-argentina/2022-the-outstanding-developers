Class {
	#name : #CardAwarderEffect,
	#superclass : #Object,
	#instVars : [
		'cardGenerator',
		'deck'
	],
	#classInstVars : [
		'randomCardGenerator',
		'deck'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardAwarderEffect class >> associatedTo: aFiniteDeck [ 
	
	^self new initializeAsociatedTo: aFiniteDeck
]

{ #category : #'instance creation' }
CardAwarderEffect class >> create [

	^ self new initializeAsociatedTo: deck
]

{ #category : #'instance creation' }
CardAwarderEffect class >> withA: finiteDeck [

	deck := finiteDeck 
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

	^ deck dealCard 
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
CardAwarderEffect >> initializeAsociatedTo: aFiniteDeck [ 
	
	deck := aFiniteDeck 
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

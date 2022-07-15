Class {
	#name : #RedoCard,
	#superclass : #Object,
	#instVars : [
		'card'
	],
	#classInstVars : [
		'target',
		'lastPlayedCard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
RedoCard class >> addTo: anOutstandingSpaceshipsGame [ 
	
	lastPlayedCard incorporateTo: anOutstandingSpaceshipsGame the: self.
]

{ #category : #assertion }
RedoCard class >> assertACardHasBeenPlayed [

	lastPlayedCard = '' ifTrue: [ 
		Error signal: 'No card has been played yet' ]
]

{ #category : #initialization }
RedoCard class >> create [

	^ self new initializeWithCard: EmptyCard new
]

{ #category : #'instance creation' }
RedoCard class >> createWithCard [

	^ self new initializeWithCard: lastPlayedCard
]

{ #category : #playing }
RedoCard class >> incorporateTo: anOutstandingSpaceshipsGame [

	lastPlayedCard := anOutstandingSpaceshipsGame lastPlayedCard.
	self assertACardHasBeenPlayed.
	lastPlayedCard
		incorporate: self
		to: anOutstandingSpaceshipsGame
]

{ #category : #playing }
RedoCard class >> playOnceIn: anOutstandingSpaceshipsGame [

	self addTo: anOutstandingSpaceshipsGame 
]

{ #category : #accessing }
RedoCard class >> target [

	^ target
]

{ #category : #playing }
RedoCard class >> thrownAt: aTarget [

	target := aTarget
]

{ #category : #comparing }
RedoCard >> = aCard [

	^ self class = aCard
]

{ #category : #assertions }
RedoCard >> assertItIsThrowableInTurn: anAssertion in: anOutstandingSpaceshipsGame [

	^ true
]

{ #category : #accessing }
RedoCard >> card [

	^ card
]

{ #category : #initialization }
RedoCard >> initializeWithCard: aCard [

	card := aCard
]

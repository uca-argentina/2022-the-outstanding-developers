Class {
	#name : #RedoCard,
	#superclass : #Object,
	#instVars : [
		'card',
		'typeOfCard'
	],
	#classInstVars : [
		'target',
		'lastPlayedCard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
RedoCard class >> addTo: aGame [ 
	
	lastPlayedCard incorporateTo: aGame the: self.
]

{ #category : #assertion }
RedoCard class >> assertACardHasBeenPlayed [

	lastPlayedCard = NullCard ifTrue: [ 
		Error signal: 'No card has been played yet' ]
]

{ #category : #'instance creation' }
RedoCard class >> create [

	^ self new initializeWithCard: NullCard new as: InstantaneousCard new
]

{ #category : #'instance creation' }
RedoCard class >> createWithCard [

	^ self new initializeWithCard: lastPlayedCard as: InstantaneousCard new
]

{ #category : #playing }
RedoCard class >> incorporateTo: aGame [

	lastPlayedCard := aGame lastPlayedCard.
	self assertACardHasBeenPlayed.
	lastPlayedCard incorporate: self to: aGame
]

{ #category : #assertion }
RedoCard class >> isPermanent [

	^ false
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
RedoCard >> assertItIsThrowableInTurn: anAssertion in: aGame [

	typeOfCard canBeThrownWithCurrentTurn: anAssertion
]

{ #category : #accessing }
RedoCard >> card [

	^ card
]

{ #category : #initialization }
RedoCard >> initializeWithCard: aCard as: aTypeOfCard [

	typeOfCard := aTypeOfCard.
	card := aCard
]

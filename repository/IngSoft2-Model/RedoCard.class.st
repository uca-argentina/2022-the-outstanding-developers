Class {
	#name : #RedoCard,
	#superclass : #Object,
	#instVars : [
		'card',
		'typeOfCard',
		'name',
		'target',
		'lastPlayedCard'
	],
	#classInstVars : [
		'target',
		'lastPlayedCard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
RedoCard class >> create [

	^ self new initializeWithCard: NullCard new as: InstantaneousCard new
]

{ #category : #'instance creation' }
RedoCard class >> createWithCard [

	^ self new initializeWithCard: lastPlayedCard as: InstantaneousCard new
]

{ #category : #'instance creation' }
RedoCard class >> identifiedAs: aName thrownAt: aSpaceship [

	^ self new
		  initializeNamed: aName
		  aimedAt: aSpaceship
		  asA: InstantaneousCard new
]

{ #category : #assertion }
RedoCard class >> isPermanent [

	^ false
]

{ #category : #comparing }
RedoCard >> = aCard [

	^ self class = aCard class and: [ name = aCard identification ]
]

{ #category : #playing }
RedoCard >> addTo: aGame [ 
	
	lastPlayedCard reIncorporateTo: aGame the: self.
]

{ #category : #asserting }
RedoCard >> assertACardHasBeenPlayed [

	lastPlayedCard = NullCard ifTrue: [ 
		Error signal: 'No card has been played yet' ]
]

{ #category : #assertions }
RedoCard >> assertItIsThrowableInTurn: anAssertion in: aGame [

	typeOfCard canBeThrownWithCurrentTurnBeing: anAssertion
]

{ #category : #accessing }
RedoCard >> card [

	^ card
]

{ #category : #palying }
RedoCard >> createWithCard [

	^ RedoCard new initializeWithCard: lastPlayedCard as: InstantaneousCard new
]

{ #category : #accessing }
RedoCard >> identification [

	^ name
]

{ #category : #playing }
RedoCard >> incorporateTo: aGame [

	lastPlayedCard := aGame lastPlayedCard.
	self assertACardHasBeenPlayed.
	lastPlayedCard incorporate: self to: aGame
]

{ #category : #initialization }
RedoCard >> initializeNamed: aName aimedAt: aSpaceship asA: aTypeOfCard [

	name := aName.
	target := aSpaceship.
	typeOfCard := aTypeOfCard
]

{ #category : #initialization }
RedoCard >> initializeWithCard: aCard as: aTypeOfCard [

	typeOfCard := aTypeOfCard.
	card := aCard
]

{ #category : #playing }
RedoCard >> playOnceIn: aGame [

	self addTo: aGame 
]

{ #category : #playing }
RedoCard >> target [

	^ target
]

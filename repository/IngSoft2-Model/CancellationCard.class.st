Class {
	#name : #CancellationCard,
	#superclass : #Object,
	#instVars : [
		'typeOfCard'
	],
	#classInstVars : [
		'cardType',
		'spaceship',
		'targetCard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CancellationCard class >> create [

	^ self new initializeAs: InstantaneousCard new
]

{ #category : #playing }
CancellationCard class >> incorporateTo: anOutstandingSpaceshipsGame [

	InstantaneousCard new incorporate: self to: anOutstandingSpaceshipsGame
]

{ #category : #playing }
CancellationCard class >> playOnceIn: anOutstandingSpaceshipsGame [ 
	
	targetCard cancelIn: anOutstandingSpaceshipsGame
]

{ #category : #playing }
CancellationCard class >> thrownAt: aCard [

	cardType := InstantaneousCard.
	targetCard := aCard
]

{ #category : #comparing }
CancellationCard >> = aCard [

	^ self class = aCard
]

{ #category : #asserting }
CancellationCard >> assertItIsThrowableIfCurrentTurnBelongingToSpaceshipIs: anAssertion [

	typeOfCard canBeThrownWithCurrentTurn: anAssertion
]

{ #category : #asserting }
CancellationCard >> assertItIsThrowableInTurn: anAssertion in: aGame [

	self assertItIsThrowableIfCurrentTurnBelongingToSpaceshipIs:
		anAssertion.
	self assertThereArePermantCardsIn: aGame
]

{ #category : #asserting }
CancellationCard >> assertThereArePermantCardsIn: aGame [

	aGame countActivePermanentCards = 0 ifTrue: [ 
		Error signal:
			'Cancellation card cant be used if there are no Permanet Cards in game' ]
]

{ #category : #accessing }
CancellationCard >> cardBehaviour [

	^ typeOfCard
]

{ #category : #playing }
CancellationCard >> incorporate: aCard to: anOutstandingSpaceshipsGame [ 
	
	self cardBehaviour incorporate: aCard to: anOutstandingSpaceshipsGame 
]

{ #category : #playing }
CancellationCard >> incorporateTo: anOutstandingSpaceshipsGame the: cardElement [

	cardElement target cancelIn: anOutstandingSpaceshipsGame
]

{ #category : #initialization }
CancellationCard >> initializeAs: aTypeOfcard [

	typeOfCard := aTypeOfcard
]

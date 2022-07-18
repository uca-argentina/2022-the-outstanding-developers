Class {
	#name : #CancellationCard,
	#superclass : #Object,
	#instVars : [
		'typeOfCard'
	],
	#classInstVars : [
		'cardType',
		'targetCard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
CancellationCard class >> assertTargetIsAPermanentCard [

	targetCard isPermanent ifFalse: [ 
		Error signal:
			'Cancellation card can only be played with Permanent Cards' ]
]

{ #category : #'instance creation' }
CancellationCard class >> create [

	^ self new initializeAs: InstantaneousCard new
]

{ #category : #playing }
CancellationCard class >> incorporateTo: aGame [
	
	self assertTargetIsAPermanentCard.
	InstantaneousCard new incorporate: self to: aGame
]

{ #category : #properties }
CancellationCard class >> isPermanent [

	^ false
]

{ #category : #playing }
CancellationCard class >> playOnceIn: aGame [ 
	
	targetCard cancelIn: aGame
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

	typeOfCard canBeThrownWithCurrentTurnBeing: anAssertion
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
CancellationCard >> incorporate: aCard to: aGame [ 
	
	self cardBehaviour incorporate: aCard to: aGame 
]

{ #category : #playing }
CancellationCard >> incorporateTo: aGame the: selectedCard [

	selectedCard target cancelIn: aGame
]

{ #category : #initialization }
CancellationCard >> initializeAs: aTypeOfcard [

	typeOfCard := aTypeOfcard
]

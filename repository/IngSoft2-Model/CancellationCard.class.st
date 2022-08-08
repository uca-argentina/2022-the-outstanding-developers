Class {
	#name : #CancellationCard,
	#superclass : #Object,
	#instVars : [
		'typeOfCard',
		'name',
		'target'
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

{ #category : #asserting }
CancellationCard class >> identifiedAs: aName thrownAt: aCardId [

	^ self new
		  initializeNamed: aName
		  aimedAt: aCardId
		  asA: InstantaneousCard new
]

{ #category : #comparing }
CancellationCard >> = aCard [

	^ self class = aCard class and: [ name = aCard identification ]
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
CancellationCard >> assertTargetIsAPermanentCardOn: aGame [

	| targetCard |
	targetCard := aGame card: target.
	targetCard isPermanent ifFalse: [ 
		Error signal:
			'Cancellation card can only be played with Permanent Cards' ]
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

{ #category : #accessing }
CancellationCard >> identification [

	^ name
]

{ #category : #playing }
CancellationCard >> incorporate: aCard to: aGame [ 
	
	self cardBehaviour incorporate: aCard to: aGame 
]

{ #category : #playing }
CancellationCard >> incorporateTo: aGame [

	self assertTargetIsAPermanentCardOn: aGame.
	typeOfCard incorporate: self to: aGame
]

{ #category : #initialization }
CancellationCard >> initializeAs: aTypeOfcard [

	typeOfCard := aTypeOfcard
]

{ #category : #accessing }
CancellationCard >> initializeNamed: aName aimedAt: aCardId asA: aTypeOfCard [

	name := aName.
	target := aCardId.
	typeOfCard := aTypeOfCard
]

{ #category : #playing }
CancellationCard >> playOnceIn: aGame [ 
	
	(aGame card: target) cancelIn: aGame
]

{ #category : #playing }
CancellationCard >> reIncorporateTo: aGame the: selectedCard [

	(aGame card: selectedCard target) cancelIn: aGame
]

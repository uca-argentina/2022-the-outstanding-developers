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
CancellationCard class >> asA: aTypeOfCard [

	^ self new initializeAs: aTypeOfCard
]

{ #category : #'class initialization' }
CancellationCard class >> behavingAsA: typeOfCard [
	
	cardType := typeOfCard 
]

{ #category : #accessing }
CancellationCard class >> cardName [

	^ 'Cancellation'
]

{ #category : #'instance creation' }
CancellationCard class >> create [

	^ self new initializeAs: cardType new
]

{ #category : #playing }
CancellationCard class >> incorporateTo: anOutstandingSpaceshipsGame [ 
	| aTypeOfCard |
	aTypeOfCard := cardType new.
	aTypeOfCard incorporate: self To: anOutstandingSpaceshipsGame.
]

{ #category : #playing }
CancellationCard class >> playOnceIn: anOutstandingSpaceshipsGame [ 
	
	anOutstandingSpaceshipsGame cancel: targetCard affecting: spaceship
]

{ #category : #playing }
CancellationCard class >> thrownAt: aCard affecting: aSpaceship asA: typeOfCard [

	spaceship := aSpaceship.
	cardType := typeOfCard.
	targetCard := aCard
]

{ #category : #comparing }
CancellationCard >> = aCard [

	^ self class = aCard
]

{ #category : #initialization }
CancellationCard >> asA: anInstantaneousCard [ 
	self shouldBeImplemented.
]

{ #category : #'instance creation' }
CancellationCard >> assertItIsThrowableIfCurrentTurnBelongingToSpaceshipIs: anAssertion [

	typeOfCard canBeThrownWithCurrentTurn: anAssertion
]

{ #category : #asserting }
CancellationCard >> assertItIsThrowableInTurn: anAssertion in: aGame [
	self assertItIsThrowableIfCurrentTurnBelongingToSpaceshipIs: anAssertion.
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

{ #category : #effect }
CancellationCard >> effectOnThrow [
	^0
]

{ #category : #playing }
CancellationCard >> incorporateTo: anOutstandingSpaceshipsGame theElement: aCard [

	anOutstandingSpaceshipsGame
		cancel: aCard target cardName
		affecting: aCard target spaceship
]

{ #category : #initialization }
CancellationCard >> initializeAs: aTypeOfcard [

	typeOfCard := aTypeOfcard
]

{ #category : #accessing }
CancellationCard >> name [

	^ 'Cancellation'
]

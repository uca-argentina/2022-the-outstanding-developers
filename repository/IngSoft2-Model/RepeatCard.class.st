Class {
	#name : #RepeatCard,
	#superclass : #Object,
	#instVars : [
		'typeOfCard'
	],
	#classInstVars : [
		'cardType',
		'spaceship'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
RepeatCard class >> behavingAsA: typeOfCard [
	
	cardType := typeOfCard 
]

{ #category : #initialization }
RepeatCard class >> create [

	^ self new initializeAs: cardType new
]

{ #category : #playing }
RepeatCard class >> incorporateTo: anOutstandingSpaceshipsGame [ 
	| aTypeOfCard |
	aTypeOfCard := cardType new.
	aTypeOfCard incorporate: self To: anOutstandingSpaceshipsGame.
]

{ #category : #playing }
RepeatCard class >> playOnceIn: anOutstandingSpaceshipsGame [

	anOutstandingSpaceshipsGame repeatEffectOn: spaceship
]

{ #category : #'class initialization' }
RepeatCard class >> thrownAt: aSpaceship [

	spaceship := aSpaceship
]

{ #category : #accessing }
RepeatCard >> = aCard [

	^ self class = aCard
]

{ #category : #asserting }
RepeatCard >> assertItIsThrowableIfCurrentTurnBelongingToSpaceshipIs: anAssertion [

	typeOfCard canBeThrownWithCurrentTurn: anAssertion
]

{ #category : #asserting }
RepeatCard >> assertItIsThrowableInTurn: anAssertion in: aGame [

	self assertItIsThrowableIfCurrentTurnBelongingToSpaceshipIs:
		anAssertion
]

{ #category : #initialization }
RepeatCard >> initializeAs: aTypeOfCard [

	typeOfCard := aTypeOfCard
]

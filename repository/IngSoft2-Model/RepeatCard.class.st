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

{ #category : #'instance creation' }
RepeatCard class >> create [

	^ self new initializeAs: InstantaneousCard new
]

{ #category : #playing }
RepeatCard class >> incorporateTo: anOutstandingSpaceshipsGame [

	InstantaneousCard new incorporate: self to: anOutstandingSpaceshipsGame
]

{ #category : #testing }
RepeatCard class >> isPermanent [

	^ false
]

{ #category : #playing }
RepeatCard class >> playOnceIn: anOutstandingSpaceshipsGame [

	anOutstandingSpaceshipsGame repeatEffectOn: spaceship
]

{ #category : #'class initialization' }
RepeatCard class >> thrownAt: aSpaceship [

	spaceship := aSpaceship.
	cardType := InstantaneousCard 
]

{ #category : #comparing }
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

{ #category : #accessing }
RepeatCard >> cardBehaviour [

	^ typeOfCard
]

{ #category : #playing }
RepeatCard >> incorporate: aCard to: anOutstandingSpaceshipsGame [ 
	
	self cardBehaviour incorporate: aCard to: anOutstandingSpaceshipsGame 
]

{ #category : #playing }
RepeatCard >> incorporateTo: anOutstandingSpaceshipsGame the: element [ 
	
	anOutstandingSpaceshipsGame repeatEffectOn: element target
]

{ #category : #initialization }
RepeatCard >> initializeAs: aTypeOfCard [

	typeOfCard := aTypeOfCard
]

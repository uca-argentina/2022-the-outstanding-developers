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
RepeatCard class >> incorporateTo: aGame [

	InstantaneousCard new incorporate: self to: aGame
]

{ #category : #asserting }
RepeatCard class >> isPermanent [

	^ false
]

{ #category : #playing }
RepeatCard class >> playOnceIn: aGame [

	aGame repeatEffectOn: spaceship
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
RepeatCard >> assertItIsThrowableInTurn: anAssertion in: aGame [

	typeOfCard canBeThrownWithCurrentTurnBeing: anAssertion
]

{ #category : #accessing }
RepeatCard >> cardBehaviour [

	^ typeOfCard
]

{ #category : #playing }
RepeatCard >> incorporate: aCard to: aGame [ 
	
	self cardBehaviour incorporate: aCard to: aGame 
]

{ #category : #playing }
RepeatCard >> incorporateTo: aGame the: selectedCard [ 
	
	aGame repeatEffectOn: selectedCard target
]

{ #category : #initialization }
RepeatCard >> initializeAs: aTypeOfCard [

	typeOfCard := aTypeOfCard
]

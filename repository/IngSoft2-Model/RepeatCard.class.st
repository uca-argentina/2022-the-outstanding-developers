Class {
	#name : #RepeatCard,
	#superclass : #Object,
	#instVars : [
		'typeOfCard',
		'name',
		'target'
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

{ #category : #'instance creation' }
RepeatCard class >> identifiedAs: aName thrownAt: aSpaceship [

	^ self new
		  initializeNamed: aName
		  aimedAt: aSpaceship
		  asA: InstantaneousCard new
]

{ #category : #asserting }
RepeatCard class >> isPermanent [

	^ false
]

{ #category : #comparing }
RepeatCard >> = aCard [

	^ self class = aCard class and: [ name = aCard identification ]
]

{ #category : #asserting }
RepeatCard >> assertItIsThrowableInTurn: anAssertion in: aGame [

	typeOfCard canBeThrownWithCurrentTurnBeing: anAssertion
]

{ #category : #accessing }
RepeatCard >> cardBehaviour [

	^ typeOfCard
]

{ #category : #accessing }
RepeatCard >> identification [

	^ name
]

{ #category : #playing }
RepeatCard >> incorporate: aCard to: aGame [ 
	
	self cardBehaviour incorporate: aCard to: aGame 
]

{ #category : #playing }
RepeatCard >> incorporateTo: aGame [

	typeOfCard incorporate: self to: aGame
]

{ #category : #initialization }
RepeatCard >> initializeAs: aTypeOfCard [

	typeOfCard := aTypeOfCard
]

{ #category : #initialization }
RepeatCard >> initializeNamed: aName aimedAt: aSpaceship asA: aTypeOfCard [

	name := aName.
	target := aSpaceship.
	typeOfCard := aTypeOfCard
]

{ #category : #playing }
RepeatCard >> playOnceIn: aGame [

	aGame repeatEffectOn: target
]

{ #category : #playing }
RepeatCard >> reIncorporateTo: aGame the: selectedCard [ 
	
	aGame repeatEffectOn: selectedCard target
]

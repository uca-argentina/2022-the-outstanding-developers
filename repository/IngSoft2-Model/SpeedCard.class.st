Class {
	#name : #SpeedCard,
	#superclass : #Object,
	#instVars : [
		'typeOfCard',
		'name',
		'target'
	],
	#classInstVars : [
		'spaceship'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SpeedCard class >> create [

	^ self new initializeAs: PermanentCard new
]

{ #category : #'instance creation' }
SpeedCard class >> identifiedAs: aName thrownAt: aSpaceship [

	^ self new
		  initializeNamed: aName
		  aimedAt: aSpaceship
		  asA: PermanentCard new
]

{ #category : #asserting }
SpeedCard class >> isPermanent [

	^ true
]

{ #category : #comparing }
SpeedCard >> = aCard [

	^ self class = aCard class and: [ name = aCard identification ]
]

{ #category : #playing }
SpeedCard >> addAffecting: aCard to: aGame [

	aGame add: aCard affecting: self
]

{ #category : #playing }
SpeedCard >> addTo: aGame [

	aGame addAffecting:
		(SpaceshipHoldingACard of: target holding: self)
]

{ #category : #asserting }
SpeedCard >> assertItIsThrowableIfCurrentTurnBelongingToSpaceshipIs: anAssertion [

	typeOfCard canBeThrownWithCurrentTurnBeing: anAssertion
]

{ #category : #asserting }
SpeedCard >> assertItIsThrowableInTurn: anAssertion in: anOutstandingSpaceshipsGame [

	self assertItIsThrowableIfCurrentTurnBelongingToSpaceshipIs:
		anAssertion
]

{ #category : #playing }
SpeedCard >> cancelIn: aGame [

	aGame cancel: self
]

{ #category : #accessing }
SpeedCard >> cardBehaviour [

	^ typeOfCard
]

{ #category : #effect }
SpeedCard >> effectOnThrow [

	^ 1
]

{ #category : #accessing }
SpeedCard >> identification [

	^ name
]

{ #category : #playing }
SpeedCard >> incorporate: aCard to: aGame [ 
	
	self cardBehaviour incorporate: aCard to: aGame
]

{ #category : #playing }
SpeedCard >> incorporateTo: aGame [

	typeOfCard incorporate: self to: aGame
]

{ #category : #initialization }
SpeedCard >> initializeAs: aTypeOfCard [

	typeOfCard := aTypeOfCard
]

{ #category : #initialization }
SpeedCard >> initializeNamed: aName aimedAt: aSpaceship asA: aTypeOfCard [

	name := aName.
	target := aSpaceship.
	typeOfCard := aTypeOfCard
]

{ #category : #playing }
SpeedCard >> isAppliedTo: aString [ 
	self shouldBeImplemented.
]

{ #category : #playing }
SpeedCard >> isPermanent [

	^ true
]

{ #category : #accessing }
SpeedCard >> name [

	^ 'Speed'
]

{ #category : #playing }
SpeedCard >> reIncorporateTo: aGame the: element [

	| cardHolder |
	cardHolder := SpaceshipHoldingACard
		              of: element target
		              holding: (SpeedCard identifiedAs: 'r',name thrownAt: target).
	aGame addAffecting: cardHolder
]

{ #category : #accessing }
SpeedCard >> target [

	^ target
]

{ #category : #accessing }
SpeedCard >> typeOfCard [

	^ typeOfCard name
]

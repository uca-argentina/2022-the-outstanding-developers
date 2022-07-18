Class {
	#name : #SpeedCard,
	#superclass : #Object,
	#instVars : [
		'typeOfCard'
	],
	#classInstVars : [
		'spaceship'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
SpeedCard class >> addAffectingCard: aCard to: aGame [

	aGame addCardAffectingCard: aCard on: self
]

{ #category : #playing }
SpeedCard class >> addTo: aGame [

	aGame addAffecting:
		(SpaceshipHoldingACard of: spaceship holding: self create)
]

{ #category : #playing }
SpeedCard class >> cancelIn: aGame [

	aGame cancel: self create affecting: spaceship
]

{ #category : #'instance creation' }
SpeedCard class >> create [

	^ self new initializeAs: PermanentCard new
]

{ #category : #playing }
SpeedCard class >> incorporateTo: aGame [

	PermanentCard new incorporate: self to: aGame
]

{ #category : #asserting }
SpeedCard class >> isAppliedTo: aSpaceship [

	^ spaceship = aSpaceship
]

{ #category : #asserting }
SpeedCard class >> isPermanent [

	^ true
]

{ #category : #accessing }
SpeedCard class >> spaceship [

	^ spaceship
]

{ #category : #'card throwing' }
SpeedCard class >> thrownAt: aSpaceship [

	spaceship := aSpaceship
]

{ #category : #comparing }
SpeedCard >> = aCard [

	^ self class = aCard
]

{ #category : #asserting }
SpeedCard >> assertItIsThrowableIfCurrentTurnBelongingToSpaceshipIs: anAssertion [

	typeOfCard canBeThrownWithCurrentTurn: anAssertion
]

{ #category : #asserting }
SpeedCard >> assertItIsThrowableInTurn: anAssertion in: anOutstandingSpaceshipsGame [

	self assertItIsThrowableIfCurrentTurnBelongingToSpaceshipIs:
		anAssertion
]

{ #category : #accessing }
SpeedCard >> cardBehaviour [

	^ typeOfCard
]

{ #category : #effect }
SpeedCard >> effectOnThrow [

	^ 1
]

{ #category : #playing }
SpeedCard >> incorporate: aCard to: anOutstandingSpaceshipsGame [ 
	
	self cardBehaviour incorporate: aCard to: anOutstandingSpaceshipsGame
]

{ #category : #playing }
SpeedCard >> incorporateTo: anOutstandingSpaceshipsGame the: element [

	| cardHolder |
	cardHolder := SpaceshipHoldingACard
		              of: element target
		              holding: element createWithCard card.
	anOutstandingSpaceshipsGame addAffecting: cardHolder
]

{ #category : #initialization }
SpeedCard >> initializeAs: aTypeOfCard [

	typeOfCard := aTypeOfCard
]

{ #category : #accessing }
SpeedCard >> name [

	^ 'Speed'
]

{ #category : #accessing }
SpeedCard >> typeOfCard [

	^ typeOfCard name
]

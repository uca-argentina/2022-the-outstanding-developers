Class {
	#name : #AccelerationCard,
	#superclass : #Object,
	#instVars : [
		'typeOfCard'
	],
	#classInstVars : [
		'cardType'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
AccelerationCard class >> addAffectingCard: aCard to: aGame [ 
	
	aGame addCardAffectingAll: aCard for: self
]

{ #category : #playing }
AccelerationCard class >> addTo: anOutstandingSpaceshipsGame [

	anOutstandingSpaceshipsGame addAffectingAll: self create.
]

{ #category : #playing }
AccelerationCard class >> cancelIn: anOutstandingSpaceshipsGame [

	anOutstandingSpaceshipsGame cancelAll: self create
]

{ #category : #initialization }
AccelerationCard class >> create [

	^ self new initializeAs: PermanentCard new
]

{ #category : #playing }
AccelerationCard class >> incorporateTo: anOutstandingSpaceshipsGame [

	PermanentCard new incorporate: self to: anOutstandingSpaceshipsGame
]

{ #category : #playing }
AccelerationCard class >> isAppliedTo: aSpaceship [

	^ true
]

{ #category : #properties }
AccelerationCard class >> isPermanent [

	^ true
]

{ #category : #accessing }
AccelerationCard class >> spaceship [
	^ ''
]

{ #category : #comparing }
AccelerationCard >> = aCard [

	^ self class = aCard
]

{ #category : #asserting }
AccelerationCard >> assertItIsThrowableIfCurrentTurnBelongingToSpaceshipIs: anAssertion [

	typeOfCard canBeThrownWithCurrentTurn: anAssertion
]

{ #category : #asserting }
AccelerationCard >> assertItIsThrowableInTurn: anAssertion in: anOutstandingSpaceshipsGame [

	self assertItIsThrowableIfCurrentTurnBelongingToSpaceshipIs:
		anAssertion
]

{ #category : #accessing }
AccelerationCard >> cardBehaviour [

	^ typeOfCard
]

{ #category : #effect }
AccelerationCard >> effectOnThrow [

	^ 1
]

{ #category : #playing }
AccelerationCard >> incorporate: aCard to: anOutstandingSpaceshipsGame [ 
	
	self cardBehaviour incorporate: aCard to: anOutstandingSpaceshipsGame 
]

{ #category : #playing }
AccelerationCard >> incorporateTo: anOutstandingSpaceshipsGame the: cardElement [

	anOutstandingSpaceshipsGame addAffectingAll:
		cardElement createWithCard card
]

{ #category : #initialization }
AccelerationCard >> initializeAs: aTypeOfCard [

	typeOfCard := aTypeOfCard
]

{ #category : #accessing }
AccelerationCard >> name [

	^ 'Acceleration'
]

{ #category : #accessing }
AccelerationCard >> typeOfCard [

	^ typeOfCard name
]

Class {
	#name : #SpeedCard,
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

{ #category : #playing }
SpeedCard class >> addAffectingCard: aCard to: aGame [ 
	aGame addCardAffectingCard: aCard on: self
]

{ #category : #playing }
SpeedCard class >> addTo: anOutstandingSpaceshipsGame [

	anOutstandingSpaceshipsGame addAffecting:
		(SpaceshipCardHolder of: spaceship holding: self create)
]

{ #category : #playing }
SpeedCard class >> cancelIn: anOutstandingSpaceshipsGame [

	anOutstandingSpaceshipsGame cancel: self create affecting: spaceship
]

{ #category : #'instance creation' }
SpeedCard class >> create [

	^ self new initializeAs: PermanentCard new
]

{ #category : #playing }
SpeedCard class >> incorporateTo: anOutstandingSpaceshipsGame [

	PermanentCard new incorporate: self to: anOutstandingSpaceshipsGame
]

{ #category : #playing }
SpeedCard class >> isAppliedTo: aSpaceship [

	^ spaceship = aSpaceship
]

{ #category : #proper }
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
	cardHolder := SpaceshipCardHolder
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

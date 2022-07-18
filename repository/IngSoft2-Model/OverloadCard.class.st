Class {
	#name : #OverloadCard,
	#superclass : #Object,
	#instVars : [
		'typeOfCard'
	],
	#classInstVars : [
		'typeOfCard',
		'spaceship'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
OverloadCard class >> addAffectingCard: aCard to: aGame [

	aGame addCardAffectingCard: aCard on: self
]

{ #category : #playing }
OverloadCard class >> addTo: anOutstandingSpaceshipsGame [

	anOutstandingSpaceshipsGame addAffecting:
		(SpaceshipCardHolder of: spaceship holding: self create)
]

{ #category : #playing }
OverloadCard class >> cancelIn: anOutstandingSpaceshipsGame [

	anOutstandingSpaceshipsGame cancel: self create affecting: spaceship
]

{ #category : #'instance creation' }
OverloadCard class >> create [

	^ self new initializeAs: PermanentCard new
]

{ #category : #playing }
OverloadCard class >> incorporateTo: anOutstandingSpaceshipsGame [

	PermanentCard new incorporate: self to: anOutstandingSpaceshipsGame
]

{ #category : #playing }
OverloadCard class >> isAppliedTo: aSpaceship [

	^ spaceship = aSpaceship
]

{ #category : #properties }
OverloadCard class >> isPermanent [

	^ true
]

{ #category : #accessing }
OverloadCard class >> spaceship [

	^ spaceship
]

{ #category : #throwing }
OverloadCard class >> thrownAt: aSpaceship [

	spaceship := aSpaceship.
	typeOfCard := PermanentCard
]

{ #category : #comparing }
OverloadCard >> = aCard [

	^ self class = aCard
]

{ #category : #asserting }
OverloadCard >> assertItIsThrowableIfCurrentTurnBelongingToSpaceshipIs: anAssertion [

	typeOfCard canBeThrownWithCurrentTurn: anAssertion
]

{ #category : #asserting }
OverloadCard >> assertItIsThrowableInTurn: anAssertion in: anOutstandingSpaceshipsGame [

	self assertItIsThrowableIfCurrentTurnBelongingToSpaceshipIs:
		anAssertion
]

{ #category : #accessing }
OverloadCard >> cardBehaviour [

	^ typeOfCard
]

{ #category : #effect }
OverloadCard >> effectOnThrow [

	^ -2
]

{ #category : #playing }
OverloadCard >> incorporate: aCard to: anOutstandingSpaceshipsGame [ 
	
	self cardBehaviour incorporate: aCard to: anOutstandingSpaceshipsGame
]

{ #category : #playing }
OverloadCard >> incorporateTo: anOutstandingSpaceshipsGame the: element [

	| cardHolder |
	cardHolder := SpaceshipCardHolder
		              of: element target
		              holding: element createWithCard card.
	anOutstandingSpaceshipsGame addAffecting: cardHolder
]

{ #category : #initialization }
OverloadCard >> initializeAs: aTypeOfCard [

	typeOfCard := aTypeOfCard
]

{ #category : #accessing }
OverloadCard >> name [

	^ 'Overload'
]

{ #category : #accessing }
OverloadCard >> typeOfCard [

	^ typeOfCard name
]

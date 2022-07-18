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
OverloadCard class >> addTo: aGame [

	aGame addAffecting:
		(SpaceshipHoldingACard of: spaceship holding: self create)
]

{ #category : #playing }
OverloadCard class >> cancelIn: aGame [

	aGame cancel: self create affecting: spaceship
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
OverloadCard >> assertItIsThrowableInTurn: anAssertion in: aGame [

	typeOfCard canBeThrownWithCurrentTurn: anAssertion
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
OverloadCard >> incorporate: aCard to: aGame [ 
	
	self cardBehaviour incorporate: aCard to: aGame
]

{ #category : #playing }
OverloadCard >> incorporateTo: aGame the: element [

	| cardHolder |
	cardHolder := SpaceshipHoldingACard
		              of: element target
		              holding: element createWithCard card.
	aGame addAffecting: cardHolder
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

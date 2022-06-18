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
SpeedCard class >> addTo: anOutstandingSpaceshipsGame [

	anOutstandingSpaceshipsGame addAffecting:
		(SpaceshipCardHolder of: spaceship holding: self create)
]

{ #category : #'class initialization' }
SpeedCard class >> behavingAsA: typeOfCard [

	cardType := typeOfCard
]

{ #category : #playing }
SpeedCard class >> cancelIn: anOutstandingSpaceshipsGame [

	anOutstandingSpaceshipsGame cancel: 'Speed' affecting: spaceship
]

{ #category : #'instance creation' }
SpeedCard class >> create [

	^ self new initializeAs: cardType new
]

{ #category : #playing }
SpeedCard class >> incorporateTo: anOutstandingSpaceshipsGame [

	| aTypeOfCard |
	aTypeOfCard := cardType new.
	aTypeOfCard incorporate: self To: anOutstandingSpaceshipsGame
]

{ #category : #'card throwing' }
SpeedCard class >> thrownAt: aSpaceship [

	spaceship := aSpaceship
]

{ #category : #'card throwing' }
SpeedCard class >> thrownAt: aSpaceship asA: typeOfCard [

	spaceship := aSpaceship.
	cardType := typeOfCard
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

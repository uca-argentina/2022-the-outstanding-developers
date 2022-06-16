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
	anOutstandingSpaceshipsGame addAffecting: (SpaceshipCardHolder of: spaceship holding: self create )
]

{ #category : #'instance creation' }
SpeedCard class >> asA: aTypeOfCard [

	^ self new initializeAs: aTypeOfCard
]

{ #category : #'class initialization' }
SpeedCard class >> behavingAsA: typeOfCard [
	
	cardType := typeOfCard 
]

{ #category : #initialization }
SpeedCard class >> create [

	^ self new initializeAs: cardType new
]

{ #category : #playing }
SpeedCard class >> incorporateTo: anOutstandingSpaceshipsGame [ 
	| aTypeOfCard |
	aTypeOfCard := cardType new.
	aTypeOfCard incorporate: self To: anOutstandingSpaceshipsGame.
]

{ #category : #accessing }
SpeedCard class >> thrownAt: aSpaceship [

	spaceship := aSpaceship
]

{ #category : #accessing }
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

{ #category : #effect }
SpeedCard >> effectOnThrow [

	^ 1
]

{ #category : #initialization }
SpeedCard >> initializeAs: aTypeOfCard [

	typeOfCard := aTypeOfCard
]

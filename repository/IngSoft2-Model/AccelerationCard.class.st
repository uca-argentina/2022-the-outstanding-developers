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
AccelerationCard class >> addTo: anOutstandingSpaceshipsGame [

	anOutstandingSpaceshipsGame addAffectingAll: self create.
]

{ #category : #'instance creation' }
AccelerationCard class >> asA: aTypeOfCard [

	^ self new initializeAs: aTypeOfCard
]

{ #category : #'class initialization' }
AccelerationCard class >> behavingAsA: typeOfCard [
	
	cardType := typeOfCard 
]

{ #category : #playing }
AccelerationCard class >> cancelIn: anOutstandingSpaceshipsGame [ 
	anOutstandingSpaceshipsGame cancelAll: 'Acceleration'
]

{ #category : #accessing }
AccelerationCard class >> cardName [

	^ 'Acceleration'
]

{ #category : #initialization }
AccelerationCard class >> create [

	^ self new initializeAs: cardType new
]

{ #category : #playing }
AccelerationCard class >> incorporateTo: anOutstandingSpaceshipsGame [ 
	| aTypeOfCard |
	aTypeOfCard := cardType new.
	aTypeOfCard incorporate: self To: anOutstandingSpaceshipsGame.
]

{ #category : #initialization }
AccelerationCard >> = aCard [

	^ self class = aCard
]

{ #category : #asserting }
AccelerationCard >> assertItIsThrowableIfCurrentTurnBelongingToSpaceshipIs: anAssertion [

	typeOfCard canBeThrownWithCurrentTurn: anAssertion
]

{ #category : #assertions }
AccelerationCard >> assertItIsThrowableInTurn: anAssertion in: anOutstandingSpaceshipsGame [ 
	self assertItIsThrowableIfCurrentTurnBelongingToSpaceshipIs: anAssertion 
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
AccelerationCard >> incorporateTo: anOutstandingSpaceshipsGame theElement: aCard [

	anOutstandingSpaceshipsGame addAffectingAll: ((aCard createWithCard) card)
]

{ #category : #initialization }
AccelerationCard >> initializeAs: aTypeOfCard [

	typeOfCard := aTypeOfCard
]

{ #category : #accesleration }
AccelerationCard >> name [

	^ 'Acceleration'
]

{ #category : #accesing }
AccelerationCard >> typeOfCard [
	^ typeOfCard name
]

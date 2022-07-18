Class {
	#name : #AccelerationCard,
	#superclass : #Object,
	#instVars : [
		'typeOfCard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
AccelerationCard class >> addAffectingCard: aCard to: aGame [ 
	
	aGame addCardAffectingAll: aCard for: self
]

{ #category : #playing }
AccelerationCard class >> addTo: aGame [

	aGame addAffectingAll: self create.
]

{ #category : #playing }
AccelerationCard class >> cancelIn: aGame [

	aGame cancelAllFrom: self create
]

{ #category : #initialization }
AccelerationCard class >> create [

	^ self new initializeAs: PermanentCard new
]

{ #category : #playing }
AccelerationCard class >> incorporateTo: aGame [

	PermanentCard new incorporate: self to: aGame
]

{ #category : #playing }
AccelerationCard class >> isAppliedTo: aSpaceship [

	^ true
]

{ #category : #properties }
AccelerationCard class >> isPermanent [

	^ true
]

{ #category : #comparing }
AccelerationCard >> = aCard [

	^ self class = aCard
]

{ #category : #asserting }
AccelerationCard >> assertItIsThrowableInTurn: anAssertion in: aGame [

	typeOfCard canBeThrownWithCurrentTurn: anAssertion
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
AccelerationCard >> incorporate: aCard to: aGame [ 
	
	self cardBehaviour incorporate: aCard to: aGame 
]

{ #category : #playing }
AccelerationCard >> incorporateTo: aGame the: cardElement [

	aGame addAffectingAll: cardElement createWithCard card
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

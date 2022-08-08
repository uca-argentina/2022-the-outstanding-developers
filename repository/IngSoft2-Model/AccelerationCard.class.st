Class {
	#name : #AccelerationCard,
	#superclass : #Object,
	#instVars : [
		'typeOfCard',
		'name'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
AccelerationCard class >> create [

	^ self new initializeAs: PermanentCard new
]

{ #category : #'instance creation' }
AccelerationCard class >> identifiedAs: aName [

	^ self new initializeAs: PermanentCard new named: aName
]

{ #category : #comparing }
AccelerationCard >> = aCard [

	^ self class = aCard class and: [ name = aCard identification ]
]

{ #category : #playing }
AccelerationCard >> addAffecting: aCard to: aGame [ 
	
	aGame add: aCard affectingAll: self
]

{ #category : #playing }
AccelerationCard >> addTo: aGame [

	aGame addAffectingAll: self.
]

{ #category : #asserting }
AccelerationCard >> assertItIsThrowableInTurn: anAssertion in: aGame [

	typeOfCard canBeThrownWithCurrentTurnBeing: anAssertion
]

{ #category : #playing }
AccelerationCard >> cancelIn: aGame [

	aGame cancelAllFrom: self
]

{ #category : #accessing }
AccelerationCard >> cardBehaviour [

	^ typeOfCard
]

{ #category : #effect }
AccelerationCard >> effectOnThrow [

	^ 1
]

{ #category : #accessing }
AccelerationCard >> identification [

	^ name
]

{ #category : #playing }
AccelerationCard >> incorporate: aCard to: aGame [ 
	
	self cardBehaviour incorporate: aCard to: aGame 
]

{ #category : #playing }
AccelerationCard >> incorporateTo: aGame [

	typeOfCard incorporate: self to: aGame
]

{ #category : #initialization }
AccelerationCard >> initializeAs: aTypeOfCard [

	typeOfCard := aTypeOfCard
]

{ #category : #initialization }
AccelerationCard >> initializeAs: aTypeOfCard named: aName [

	typeOfCard := aTypeOfCard.
	name := aName
]

{ #category : #playing }
AccelerationCard >> isAppliedTo: aSpaceship [

	^ true
]

{ #category : #playing }
AccelerationCard >> isPermanent [

	^ true
]

{ #category : #accessing }
AccelerationCard >> name [

	^ 'Acceleration'
]

{ #category : #playing }
AccelerationCard >> reIncorporateTo: aGame the: cardElement [

	aGame addAffectingAll: (AccelerationCard identifiedAs: 'r' , name)
]

{ #category : #accessing }
AccelerationCard >> typeOfCard [

	^ typeOfCard name
]

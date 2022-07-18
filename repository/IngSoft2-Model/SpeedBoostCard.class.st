Class {
	#name : #SpeedBoostCard,
	#superclass : #Object,
	#instVars : [
		'typeOfCard',
		'targetCard'
	],
	#classInstVars : [
		'targetCard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #assertion }
SpeedBoostCard class >> assertTargetIsAPermanentCard [

	targetCard isPermanent ifFalse: [ 
		Error signal:
			'SpeedBoost card can only be played with Permanent Cards' ]
]

{ #category : #'instance creation' }
SpeedBoostCard class >> create [

	^ self new initializeAs: InstantaneousCard new towards: targetCard
]

{ #category : #playing }
SpeedBoostCard class >> incorporateTo: anOutstandingSpaceshipsGame [

	self assertTargetIsAPermanentCard.
	InstantaneousCard new
		incorporate: self
		to: anOutstandingSpaceshipsGame
]

{ #category : #playing }
SpeedBoostCard class >> playOnceIn: aGame [

	aGame assertCardCanAffect: targetCard.
	targetCard addAffectingCard: self create to: aGame
]

{ #category : #playing }
SpeedBoostCard class >> thrownAt: aCard [

	targetCard := aCard
]

{ #category : #comparing }
SpeedBoostCard >> = aCard [

	^ self class = aCard
]

{ #category : #playing }
SpeedBoostCard >> affecting: anEffectOnThrow [

	^ anEffectOnThrow * 2
]

{ #category : #assertion }
SpeedBoostCard >> assertItIsThrowableIfCurrentTurnBelongingToSpaceshipIs: anAssertion [

	typeOfCard canBeThrownWithCurrentTurn: anAssertion
]

{ #category : #assertion }
SpeedBoostCard >> assertItIsThrowableInTurn: anAssertion in: aGame [

	self assertItIsThrowableIfCurrentTurnBelongingToSpaceshipIs:
		anAssertion
]

{ #category : #accessing }
SpeedBoostCard >> cardBehaviour [

	^ typeOfCard
]

{ #category : #playing }
SpeedBoostCard >> incorporate: aCard to: aGame [

	self cardBehaviour incorporate: aCard to: aGame
]

{ #category : #playing }
SpeedBoostCard >> incorporateTo: aGame the: cardElement [

	aGame assertCardCanAffect: targetCard.
	targetCard addAffectingCard: self to: aGame
]

{ #category : #initialization }
SpeedBoostCard >> initializeAs: aTypeOfCard towards: aTargetCard [ 
	
	targetCard := aTargetCard.
	typeOfCard := aTypeOfCard
]

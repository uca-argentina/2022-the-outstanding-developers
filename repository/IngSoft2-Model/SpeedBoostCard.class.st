Class {
	#name : #SpeedBoostCard,
	#superclass : #Object,
	#instVars : [
		'typeOfCard',
		'targetCard',
		'name',
		'target'
	],
	#classInstVars : [
		'targetCard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SpeedBoostCard class >> create [

	^ self new initializeAs: InstantaneousCard new towards: targetCard
]

{ #category : #'intance creation' }
SpeedBoostCard class >> identifiedAs: aName thrownAt: aSpaceship [

	^ self new
		  initializeNamed: aName
		  aimedAt: aSpaceship
		  asA: InstantaneousCard new
]

{ #category : #comparing }
SpeedBoostCard >> = aCard [

	^ self class = aCard class and: [ name = aCard identification ]
]

{ #category : #playing }
SpeedBoostCard >> affecting: anEffectOnThrow [

	^ anEffectOnThrow * 2
]

{ #category : #assertion }
SpeedBoostCard >> assertItIsThrowableIfCurrentTurnBelongingToSpaceshipIs: anAssertion [

	typeOfCard canBeThrownWithCurrentTurnBeing: anAssertion
]

{ #category : #assertion }
SpeedBoostCard >> assertItIsThrowableInTurn: anAssertion in: aGame [

	self assertItIsThrowableIfCurrentTurnBelongingToSpaceshipIs:
		anAssertion
]

{ #category : #assertion }
SpeedBoostCard >> assertTargetIsAPermanentCard [

	targetCard isPermanent ifFalse: [ 
		Error signal:
			'SpeedBoost card can only be played with Permanent Cards' ]
]

{ #category : #accessing }
SpeedBoostCard >> cardBehaviour [

	^ typeOfCard
]

{ #category : #accessing }
SpeedBoostCard >> identification [

	^ name
]

{ #category : #playing }
SpeedBoostCard >> incorporate: aCard to: aGame [

	self cardBehaviour incorporate: aCard to: aGame
]

{ #category : #playing }
SpeedBoostCard >> incorporateTo: aGame [
	
	targetCard := aGame card: target.
	self assertTargetIsAPermanentCard.
	typeOfCard incorporate: self to: aGame
]

{ #category : #playing }
SpeedBoostCard >> incorporateTo: aGame the: cardElement [

	aGame assertCardCanAffect: targetCard.
	targetCard addAffecting: self to: aGame
]

{ #category : #initialization }
SpeedBoostCard >> initializeAs: aTypeOfCard towards: aTargetCard [ 
	
	targetCard := aTargetCard.
	typeOfCard := aTypeOfCard
]

{ #category : #initialization }
SpeedBoostCard >> initializeNamed: aName aimedAt: aSpaceship asA: aTypeOfCard [

	name := aName.
	target := aSpaceship.
	typeOfCard := aTypeOfCard
]

{ #category : #palying }
SpeedBoostCard >> playOnceIn: aGame [

	aGame assertCardCanAffect: targetCard.
	targetCard addAffecting: self to: aGame
]

{ #category : #playing }
SpeedBoostCard >> reIncorporateTo: aGame the: cardElement [

	aGame assertCardCanAffect: targetCard.
	targetCard addAffecting: (SpeedBoostCard identifiedAs: ('r',name) thrownAt: target) to: aGame
]

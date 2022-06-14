Class {
	#name : #SpeedCard,
	#superclass : #Object,
	#instVars : [
		'typeOfCard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SpeedCard class >> asA: aTypeOfCard [
	^self new initializeAs: aTypeOfCard
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

Class {
	#name : #AccelerationCard,
	#superclass : #Object,
	#instVars : [
		'typeOfCard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
AccelerationCard class >> asA: aTypeOfCard [

	^ self new initializeAs: aTypeOfCard
]

{ #category : #asserting }
AccelerationCard >> assertItIsThrowableIfCurrentTurnBelongingToSpaceshipIs: anAssertion [

	typeOfCard canBeThrownWithCurrentTurn: anAssertion
]

{ #category : #effect }
AccelerationCard >> effectOnThrow [

	^ 1
]

{ #category : #initialization }
AccelerationCard >> initializeAs: aTypeOfCard [

	typeOfCard := aTypeOfCard
]

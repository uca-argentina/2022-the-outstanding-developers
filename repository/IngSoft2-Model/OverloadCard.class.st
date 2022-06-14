Class {
	#name : #OverloadCard,
	#superclass : #Object,
	#instVars : [
		'typeOfCard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
OverloadCard class >> asA: aTypeOfCard [

	^self new initializeAs: aTypeOfCard
]

{ #category : #asserting }
OverloadCard >> assertItIsThrowableIfCurrentTurnBelongingToSpaceshipIs: anAssertion [

	typeOfCard canBeThrownWithCurrentTurn: anAssertion
]

{ #category : #effect }
OverloadCard >> effectOnThrow [

	^ -2
]

{ #category : #initialization }
OverloadCard >> initializeAs: aTypeOfCard [

	typeOfCard := aTypeOfCard
]

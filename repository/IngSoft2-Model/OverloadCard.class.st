Class {
	#name : #OverloadCard,
	#superclass : #Object,
	#instVars : [
		'typeOfCard'
	],
	#classInstVars : [
		'typeOfCard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
OverloadCard class >> asA: aTypeOfCard [

	^self new initializeAs: aTypeOfCard
]

{ #category : #'class ini' }
OverloadCard class >> behavingAsA: aTypeOfCard [

	typeOfCard := aTypeOfCard
]

{ #category : #'instance creation' }
OverloadCard class >> create [

	^ self new initializeAs: typeOfCard  new
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

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

{ #category : #'instance creation' }
AccelerationCard class >> asA: aTypeOfCard [

	^ self new initializeAs: aTypeOfCard
]

{ #category : #'class initialization' }
AccelerationCard class >> behavingAsA: typeOfCard [
	
	cardType := typeOfCard 
]

{ #category : #initialization }
AccelerationCard class >> create [

	^ self new initializeAs: cardType new
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

Class {
	#name : #CancellationCard,
	#superclass : #Object,
	#classInstVars : [
		'cardType'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CancellationCard class >> asA: aTypeOfCard [

	^ self new initializeAs: aTypeOfCard
]

{ #category : #'class initialization' }
CancellationCard class >> behavingAsA: typeOfCard [
	
	cardType := typeOfCard 
]

{ #category : #'instance creation' }
CancellationCard class >> create [

	^ self new initializeAs: cardType new
]

{ #category : #initialization }
CancellationCard >> asA: anInstantaneousCard [ 
	self shouldBeImplemented.
]

{ #category : #'instance creation' }
CancellationCard >> assertItIsThrowableIfCurrentTurnBelongingToSpaceshipIs: aBoolean [ 
	self shouldBeImplemented.
]

{ #category : #effect }
CancellationCard >> effectOnThrow [
	^0
]

{ #category : #initialization }
CancellationCard >> initializeAs: aTypeOfcard [

	| typeOfCard |
	typeOfCard := aTypeOfcard
]

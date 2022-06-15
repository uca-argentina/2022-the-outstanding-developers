Class {
	#name : #RepeatCard,
	#superclass : #Object,
	#instVars : [
		'typeOfCard'
	],
	#classInstVars : [
		'cardType'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
RepeatCard class >> behavingAsA: typeOfCard [
	
	cardType := typeOfCard 
]

{ #category : #initialization }
RepeatCard class >> create [

	^ self new initializeAs: cardType new
]

{ #category : #initialization }
RepeatCard >> initializeAs: aTypeOfCard [

	typeOfCard := aTypeOfCard
]

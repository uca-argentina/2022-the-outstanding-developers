Class {
	#name : #NoEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
NoEffect class >> create [
	^self new
]

{ #category : #effect }
NoEffect >> effectOnPosition [

	^ 0
]

{ #category : #effects }
NoEffect >> effectOnPosition: aBoard [

	
]

{ #category : #'as yet unclassified' }
NoEffect >> typeOfEffect [
	^'normal'
]

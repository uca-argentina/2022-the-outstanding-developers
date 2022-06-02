Class {
	#name : #NormalBox,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
NormalBox class >> create [
	^self new
]

{ #category : #effect }
NormalBox >> effectOnPosition [

	^ 0
]

{ #category : #effects }
NormalBox >> effectOnPosition: aBoard [

	
]

{ #category : #'as yet unclassified' }
NormalBox >> typeOfEffect [
	^'normal'
]

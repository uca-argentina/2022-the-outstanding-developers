Class {
	#name : #NoEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
NoEffect class >> create [
	^self new
]

{ #category : #effects }
NoEffect >> applyEffectOn: aBoard [

	^ (self effectOnPosition)
]

{ #category : #effect }
NoEffect >> effectOnPosition [

	^ 0
]

{ #category : #accessing }
NoEffect >> typeOfEffect [
	^'normal'
]

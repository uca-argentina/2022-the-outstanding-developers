Class {
	#name : #AtomicBombBox,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
AtomicBombBox class >> create [
	^self new
]

{ #category : #effects }
AtomicBombBox >> effectOnPosition: aBoard [

	aBoard moveAllBackToBeginning
]

{ #category : #accessing }
AtomicBombBox >> typeOfEffect [
	^'atomicbomb'
]

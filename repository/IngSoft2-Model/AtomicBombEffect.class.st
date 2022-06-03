Class {
	#name : #AtomicBombEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
AtomicBombEffect class >> create [
	^self new
]

{ #category : #effects }
AtomicBombEffect >> effectOnPosition: aBoard [

	aBoard moveAllBackToBeginning
]

{ #category : #accessing }
AtomicBombEffect >> typeOfEffect [
	^'atomicbomb'
]

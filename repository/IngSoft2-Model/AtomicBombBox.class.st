Class {
	#name : #AtomicBombBox,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #effects }
AtomicBombBox >> effectOnPosition: aBoard [ 
	aBoard moveAllBackToBeginning.
]

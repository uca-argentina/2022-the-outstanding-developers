Class {
	#name : #InstantaneousCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
InstantaneousCard >> canBeThrownWithCurrentTurn: isCurrentTurn [

	^ true
]

{ #category : #playing }
InstantaneousCard >> incorporate: aCard to: anOutstandingSpaceshipsGame [ 
	
	aCard playOnceIn: anOutstandingSpaceshipsGame 
]

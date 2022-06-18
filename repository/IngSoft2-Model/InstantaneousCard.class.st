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
InstantaneousCard >> incorporate: aCard To: anOutstandingSpaceshipsGame [ 
	
	aCard playOnceIn: anOutstandingSpaceshipsGame 
]

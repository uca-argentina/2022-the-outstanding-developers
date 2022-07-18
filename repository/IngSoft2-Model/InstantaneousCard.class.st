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
InstantaneousCard >> incorporate: aCard to: aGame [

	aCard playOnceIn: aGame.
	aGame addUsedcard: aCard create
]

Class {
	#name : #InstantaneousCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
InstantaneousCard >> canBeThrownWithCurrentTurnBeing: anAssertion [

	^ true
]

{ #category : #playing }
InstantaneousCard >> incorporate: aCard to: aGame [

	aCard playOnceIn: aGame.
	aGame addToUsedCards: aCard create
]

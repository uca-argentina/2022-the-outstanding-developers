Class {
	#name : #GameNotWonState,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
GameNotWonState >> isFinished [

	^ false
]

{ #category : #actions }
GameNotWonState >> play: aGame [

	aGame playTurn
]

Class {
	#name : #GameWonState,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
GameWonState >> isFinished [
	
	^true
]

{ #category : #playing }
GameWonState >> play: aGame [

	Error signal: 'The game has already been finished'
]

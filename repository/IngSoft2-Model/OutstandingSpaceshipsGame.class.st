Class {
	#name : #OutstandingSpaceshipsGame,
	#superclass : #Object,
	#instVars : [
		'board',
		'dice',
		'stateOfGame'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
OutstandingSpaceshipsGame class >> playedOn: aBoard throwing: dice [

	^ self new initializeWith: aBoard and: dice
]

{ #category : #initialization }
OutstandingSpaceshipsGame >> initializeWith: aBoard and: someDice [

	board := aBoard.
	dice := someDice.
	stateOfGame := GameNotWonState new
]

{ #category : #playing }
OutstandingSpaceshipsGame >> play [

	stateOfGame play: self
]

{ #category : #playing }
OutstandingSpaceshipsGame >> playTurn [

	| resultOfTheRoll |
	resultOfTheRoll := dice roll.
	board moveSpaceship: resultOfTheRoll.
	board thereIsAWinner ifTrue: [ stateOfGame := GameWonState new ]
]

{ #category : #playing }
OutstandingSpaceshipsGame >> startSimulation [

	[ self thereIsAWinner ] whileFalse: [ self playTurn ]
]

{ #category : #results }
OutstandingSpaceshipsGame >> thereIsAWinner [

	^ stateOfGame isFinished
]

{ #category : #results }
OutstandingSpaceshipsGame >> winner [

	^ board winner
]

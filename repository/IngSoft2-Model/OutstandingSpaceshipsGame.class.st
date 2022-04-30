Class {
	#name : #OutstandingSpaceshipsGame,
	#superclass : #Object,
	#instVars : [
		'board',
		'dice'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
OutstandingSpaceshipsGame class >> withABoard: aBoard andDice: dice [

	^ self new initializeWithABoard: aBoard andDice: dice
]

{ #category : #initialization }
OutstandingSpaceshipsGame >> initializeWithABoard: aBoard andDice: someDice [

	board := aBoard.
	dice := someDice
]

{ #category : #playing }
OutstandingSpaceshipsGame >> start [

	| resultOfTheRoll |
	[ self thereIsAWinner ] whileFalse: [ 
		resultOfTheRoll := dice roll.
		board moveSpaceship: resultOfTheRoll ]
]

{ #category : #results }
OutstandingSpaceshipsGame >> thereIsAWinner [

	^ board thereIsAWinner
]

{ #category : #results }
OutstandingSpaceshipsGame >> winner [

	^ board winner
]

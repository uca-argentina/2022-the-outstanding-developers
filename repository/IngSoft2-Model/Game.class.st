Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'board',
		'dice'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Game class >> withABoard: aBoard andDice: dice [
	^self new initializeWithABoard: aBoard initializeWithDice: dice.
]

{ #category : #initialization }
Game >> initializeWithABoard: aBoard initializeWithDice: someDice [ 
	board := aBoard.
	dice := someDice.
]

{ #category : #playing }
Game >> start [
	| resultOfTheRoll |
	[ self thereIsAWinner ] whileFalse: 
		[ resultOfTheRoll := dice roll.
		board moveSpaceship: resultOfTheRoll].
]

{ #category : #results }
Game >> thereIsAWinner [
	
	| isThereAWinner |
	isThereAWinner := board isThereAWinner.
	
	^isThereAWinner
]

{ #category : #results }
Game >> winner [
	^board whoIsTheWinner.
]

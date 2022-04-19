Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'board',
		'spaceships',
		'dice'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Game class >> with: aBoard [ 
	^self new initializeWith: aBoard.
]

{ #category : #'instance creation' }
Game class >> withABoard: aBoard withDice: dice [
	^self new initializeWithABoard: aBoard initializeWithDice: dice.
]

{ #category : #'instance creation' }
Game class >> withABoard: aBoard withSpaceships: spaceships withDice: dice [
	^self new initializeWithABoard: aBoard initializeWithSpaceships: spaceships initializeWithDice: dice.
]

{ #category : #initialization }
Game >> initializeWith: aBoard [ 
	board := aBoard.
]

{ #category : #initialization }
Game >> initializeWithABoard: aBoard initializeWithDice: someDice [ 
	board := aBoard.
	dice := someDice.
]

{ #category : #initialization }
Game >> initializeWithABoard: aBoard initializeWithSpaceships: someSpaceships initializeWithDice: someDice [ 
	board := aBoard.
	spaceships := someSpaceships.
	dice := someDice.
]

{ #category : #playing }
Game >> play: resultOfTheRoll [ 
	^resultOfTheRoll.
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

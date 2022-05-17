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
OutstandingSpaceshipsGame class >> playedOn: aBoard throwing: dice [

	^ self new initializeWith: aBoard and: dice
]

{ #category : #initialization }
OutstandingSpaceshipsGame >> initializeWith: aBoard and: someDice [

	board := aBoard.
	dice := someDice
]

{ #category : #playing }
OutstandingSpaceshipsGame >> play [

	| resultOfTheRoll |
	self thereIsAWinner
		ifFalse: [ 
			resultOfTheRoll := dice roll.
			board moveSpaceship: resultOfTheRoll ]
		ifTrue: [ Error signal: 'The game has already been finished' ]
]

{ #category : #playing }
OutstandingSpaceshipsGame >> startSimulation [

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

Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameTest >> testGameWithOneSpaceshipABoardWithFiveBoxesAndALoadedDieWithFourDoesNotEndAfterOneRoll [
	
	| aBoard aDice spaceship game resultOfTheRoll |
	spaceship := Spaceship assignedTo: 'APlayerName'.
	aBoard := Board withBoxes: 5 andSpaceships: spaceship.
	aDice := LoadedDie with: 4.
	
	game := Game withABoard: aBoard withDice: aDice.
	resultOfTheRoll := aDice roll.
	game play: resultOfTheRoll.
	
	self deny: (game thereIsAWinner).
]

{ #category : #tests }
GameTest >> testGameWithOneSpaceshipABoardWithFiveBoxesAndALoadedDieWithSixEndsAfterOneRoll [

	| aBoard aDice spaceship game resultOfTheRoll |
	spaceship := Spaceship assignedTo: 'APlayerName'.
	aBoard := Board withBoxes: 5 andSpaceships: spaceship.
	aDice := LoadedDie with: 6.
	
	game := Game withABoard: aBoard withDice: aDice.
	resultOfTheRoll := aDice roll.
	spaceship move: resultOfTheRoll.
	
	self assert: (game thereIsAWinner).
	
]

{ #category : #tests }
GameTest >> testStartAGame [
	Game start.
]

{ #category : #tests }
GameTest >> testStartAGameWithABoard [

	|aBoard game|
	aBoard := Board with: 10.
	game := Game with: aBoard.
	
]

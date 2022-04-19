Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameTest >> testGamePlaysByItselfWithOneSpaceshipEnds [
	
	| aSpaceship aBoard aDie game |
	aSpaceship := Spaceship assignedTo: 'Player1'.
	aBoard := Board withBoxes: 15 andSpaceship: aSpaceship.
	aDie := RandomDie with: 4.
	game := Game withABoard: aBoard withDice: aDie.
	
	game start.
	
	self assert: (game thereIsAWinner).
]

{ #category : #tests }
GameTest >> testGameWithOneSpaceshipABoardWithFiveBoxesAndALoadedDieWithFourDoesNotEndAfterOneRoll [
	
	| aBoard aDice spaceship game resultOfTheRoll |
	spaceship := Spaceship assignedTo: 'APlayerName'.
	aBoard := Board withBoxes: 5 andSpaceship: spaceship.
	aDice := LoadedDie with: 4.
	
	game := Game withABoard: aBoard withDice: aDice.
	resultOfTheRoll := aDice roll.
	spaceship move: resultOfTheRoll.
	
	self deny: (game thereIsAWinner).
]

{ #category : #tests }
GameTest >> testGameWithOneSpaceshipABoardWithFiveBoxesAndALoadedDieWithSixEndsAfterOneRoll [

	| aBoard aDice spaceship game resultOfTheRoll |
	spaceship := Spaceship assignedTo: 'APlayerName'.
	aBoard := Board withBoxes: 5 andSpaceship: spaceship.
	aDice := LoadedDie with: 6.
	
	game := Game withABoard: aBoard withDice: aDice.
	resultOfTheRoll := aDice roll.
	spaceship move: resultOfTheRoll.
	
	self assert: (game thereIsAWinner).
	
]

{ #category : #tests }
GameTest >> testGameWithTwoSpaceshipsABoardWithFiveBoxesAndALoadedDieWithThreeEnds [
	
	| aSpaceship anotherSpaceship aBoard aLoadedDie game resultOfTheRoll |
	aSpaceship := Spaceship assignedTo: 'Player1'.
	anotherSpaceship := Spaceship assignedTo: 'Player2'.
	aBoard := Board withBoxes: 5 andSpaceships: { aSpaceship. anotherSpaceship }.
	aLoadedDie := LoadedDie with: 3.
	game := Game withABoard: aBoard withDice: aLoadedDie.
	
	resultOfTheRoll := aLoadedDie roll.
	aSpaceship move: resultOfTheRoll.
	anotherSpaceship move: resultOfTheRoll.
	aSpaceship move: resultOfTheRoll.
	
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

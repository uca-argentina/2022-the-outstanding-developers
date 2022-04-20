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
GameTest >> testGamePlaysByItselfWithTwoSpaceshipsABoardWithFifteenBoxesWithALoadedDieWithASequenceOfOneAndThreeAndTheWinnerIsSecondSpaceshipIsValid [

	| aSpaceship anotherSpaceship aBoard aDie game |
	aSpaceship := Spaceship assignedTo: 'Player1'.
	anotherSpaceship := Spaceship assignedTo: 'Player2'.
	aBoard := Board withBoxes: 15 andSpaceships: {aSpaceship. anotherSpaceship}.
	aDie := LoadedDie withSequence: {1. 3}.
	game := Game withABoard: aBoard withDice: aDie.
	
	game start.
	
	self assert: game winner equals: 'Player2'.
]

{ #category : #tests }
GameTest >> testGamePlaysByItselfWithTwoSpaceshipsABoardWithFifteenBoxesWithALoadedDieWithFourAndBothSpaceshipsPlayAndMoveUntilGameEnds [

	| aSpaceship anotherSpaceship aBoard aDie game |
	aSpaceship := Spaceship assignedTo: 'Player1'.
	anotherSpaceship := Spaceship assignedTo: 'Player2'.
	aBoard := Board withBoxes: 15 andSpaceships: {aSpaceship. anotherSpaceship}.
	aDie := LoadedDie with: 4.
	game := Game withABoard: aBoard withDice: aDie.
	
	game start.
	
	self assert: (aBoard positionOf: 'Player1') equals: 16.
	self assert: (aBoard positionOf: 'Player2') equals: 12.
]

{ #category : #tests }
GameTest >> testGamePlaysByItselfWithTwoSpaceshipsAndADiceCupWithThreeDiceEnds [

	| aSpaceship anotherSpaceship aBoard aDie game anotherDie otherDie aDiceCup |
	aSpaceship := Spaceship assignedTo: 'Player1'.
	anotherSpaceship := Spaceship assignedTo: 'Player2'.
	aBoard := Board withBoxes: 50 andSpaceships: {aSpaceship. anotherSpaceship}.
	aDie := RandomDie with: 4.
	anotherDie := RandomDie with: 5.
	otherDie := RandomDie with: 6.
	aDiceCup := DiceCup withAll: { aDie. anotherDie. otherDie }.
	game := Game withABoard: aBoard withDice: aDiceCup.
	
	game start.
	
	self assert: (game thereIsAWinner).
]

{ #category : #tests }
GameTest >> testGamePlaysByItselfWithTwoSpaceshipsEnds [

	| aSpaceship anotherSpaceship aBoard aDie game |
	aSpaceship := Spaceship assignedTo: 'Player1'.
	anotherSpaceship := Spaceship assignedTo: 'Player2'.
	aBoard := Board withBoxes: 15 andSpaceships: {aSpaceship. anotherSpaceship}.
	aDie := RandomDie with: 4.
	game := Game withABoard: aBoard withDice: aDie.
	
	game start.
	
	self assert: (game thereIsAWinner).
]

{ #category : #tests }
GameTest >> testGameWithABoardWithFifteenBoxesAndASpaceshipWinsAndItsFinalPositionIsSixteen [
	
	| aSpaceship aBoard aDie game |
	aSpaceship := Spaceship assignedTo: 'Player1'.
	aBoard := Board withBoxes: 15 andSpaceship: aSpaceship.
	aDie := LoadedDie with: 5.
	game := Game withABoard: aBoard withDice: aDie.
	
	game start.
	
	self assert: (aBoard positionOf: 'Player1') equals: 16.
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
	aBoard moveSpaceship: resultOfTheRoll.
	
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
	aBoard moveSpaceship: resultOfTheRoll.
	aBoard moveSpaceship: resultOfTheRoll.
	aBoard moveSpaceship: resultOfTheRoll.
	
	self assert: (game thereIsAWinner).
]

{ #category : #tests }
GameTest >> testStartAGameWithABoard [

	|aBoard game|
	aBoard := Board with: 10.
	game := Game with: aBoard.
	
]

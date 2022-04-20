Class {
	#name : #OutstandingSpaceshipsGameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testBIGGamePlaysByItselfWithFiveSpaceshipsADiceCupWithFourRandomDiceAndABoardWithFiveHundredBoxesEnds [

	| aBoard aDie game anotherDie otherDie aDiceCup firstSpaceship secondSpaceship thirdSpaceship fourthSpaceship fifthSpaceship oneLastDie |
	firstSpaceship := Spaceship assignedTo: 'Player1'.
	secondSpaceship := Spaceship assignedTo: 'Player2'.
	thirdSpaceship := Spaceship assignedTo: 'Player3'.
	fourthSpaceship := Spaceship assignedTo: 'Player4'.
	fifthSpaceship := Spaceship assignedTo: 'Player5'.
	aBoard := Board withBoxes: 500 andSpaceships: { firstSpaceship. secondSpaceship. thirdSpaceship. fourthSpaceship. fifthSpaceship }.
	aDie := RandomDie with: 4.
	anotherDie := RandomDie with: 5.
	otherDie := RandomDie with: 6.
	oneLastDie := RandomDie with: 7.
	aDiceCup := DiceCup withAll: { aDie. anotherDie. otherDie. oneLastDie }.
	game := OutstandingSpaceshipsGame withABoard: aBoard andDice: aDiceCup.
	
	game start.
	
	self assert: (game thereIsAWinner).
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testGamePlaysByItselfWithOneSpaceshipEnds [
	
	| aSpaceship aBoard aDie game |
	aSpaceship := Spaceship assignedTo: 'Player1'.
	aBoard := Board withBoxes: 15 andSpaceship: aSpaceship.
	aDie := RandomDie with: 4.
	game := OutstandingSpaceshipsGame withABoard: aBoard andDice: aDie.
	
	game start.
	
	self assert: (game thereIsAWinner).
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testGamePlaysByItselfWithTwoSpaceshipsABoardWithFifteenBoxesWithALoadedDieWithASequenceOfOneAndThreeAndTheWinnerIsSecondSpaceshipIsValid [

	| aSpaceship anotherSpaceship aBoard aDie game |
	aSpaceship := Spaceship assignedTo: 'Player1'.
	anotherSpaceship := Spaceship assignedTo: 'Player2'.
	aBoard := Board withBoxes: 15 andSpaceships: {aSpaceship. anotherSpaceship}.
	aDie := LoadedDie withSequence: {1. 3}.
	game := OutstandingSpaceshipsGame withABoard: aBoard andDice: aDie.
	
	game start.
	
	self assert: game winner equals: 'Player2'.
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testGamePlaysByItselfWithTwoSpaceshipsABoardWithFifteenBoxesWithALoadedDieWithFourAndBothSpaceshipsPlayAndMoveUntilGameEnds [

	| aSpaceship anotherSpaceship aBoard aDie game |
	aSpaceship := Spaceship assignedTo: 'Player1'.
	anotherSpaceship := Spaceship assignedTo: 'Player2'.
	aBoard := Board withBoxes: 15 andSpaceships: {aSpaceship. anotherSpaceship}.
	aDie := LoadedDie with: 4.
	game := OutstandingSpaceshipsGame withABoard: aBoard andDice: aDie.
	
	game start.
	
	self assert: (aBoard positionOf: 'Player1') equals: 16.
	self assert: (aBoard positionOf: 'Player2') equals: 12.
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testGamePlaysByItselfWithTwoSpaceshipsAndADiceCupWithThreeDiceEnds [

	| aSpaceship anotherSpaceship aBoard aDie game anotherDie otherDie aDiceCup |
	aSpaceship := Spaceship assignedTo: 'Player1'.
	anotherSpaceship := Spaceship assignedTo: 'Player2'.
	aBoard := Board withBoxes: 50 andSpaceships: {aSpaceship. anotherSpaceship}.
	aDie := RandomDie with: 4.
	anotherDie := RandomDie with: 5.
	otherDie := RandomDie with: 6.
	aDiceCup := DiceCup withAll: { aDie. anotherDie. otherDie }.
	game := OutstandingSpaceshipsGame withABoard: aBoard andDice: aDiceCup.
	
	game start.
	
	self assert: (game thereIsAWinner).
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testGamePlaysByItselfWithTwoSpaceshipsEnds [

	| aSpaceship anotherSpaceship aBoard aDie game |
	aSpaceship := Spaceship assignedTo: 'Player1'.
	anotherSpaceship := Spaceship assignedTo: 'Player2'.
	aBoard := Board withBoxes: 15 andSpaceships: {aSpaceship. anotherSpaceship}.
	aDie := RandomDie with: 4.
	game := OutstandingSpaceshipsGame withABoard: aBoard andDice: aDie.
	
	game start.
	
	self assert: (game thereIsAWinner).
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testGameWithABoardOfTenBoxesThreeSpaceshipsAndALoadedDieWithASequenceOfOneFourThreeFinalPositionsAreThreeForTheFirstSpaceshipElevenForTheSecondOneAndSixForTheThirdOne [

	| aSpaceship anotherSpaceship aBoard aDie game otherSpaceship |
	aSpaceship := Spaceship assignedTo: 'Player1'.
	anotherSpaceship := Spaceship assignedTo: 'Player2'.
	otherSpaceship := Spaceship assignedTo: 'Player3'.
	aBoard := Board withBoxes: 10 andSpaceships: {aSpaceship. anotherSpaceship. otherSpaceship}.
	aDie := LoadedDie withSequence: {1. 4. 3}.
	game := OutstandingSpaceshipsGame withABoard: aBoard andDice: aDie.
	
	game start.
	
	self assert: (aBoard positionOf: 'Player1') equals: 3.
	self assert: (aBoard positionOf: 'Player2') equals: 11.
	self assert: (aBoard positionOf: 'Player3') equals: 6.	
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testGameWithABoardWithFifteenBoxesAndASpaceshipWinsAndItsFinalPositionIsSixteen [
	
	| aSpaceship aBoard aDie game |
	aSpaceship := Spaceship assignedTo: 'Player1'.
	aBoard := Board withBoxes: 15 andSpaceship: aSpaceship.
	aDie := LoadedDie with: 5.
	game := OutstandingSpaceshipsGame withABoard: aBoard andDice: aDie.
	
	game start.
	
	self assert: (aBoard positionOf: 'Player1') equals: 16.
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testGameWithOneSpaceshipABoardWithFiveBoxesAndALoadedDieWithFourDoesNotEndAfterOneRoll [
	
	| aBoard aDice spaceship game resultOfTheRoll |
	spaceship := Spaceship assignedTo: 'APlayerName'.
	aBoard := Board withBoxes: 5 andSpaceship: spaceship.
	aDice := LoadedDie with: 4.
	
	game := OutstandingSpaceshipsGame withABoard: aBoard andDice: aDice.
	resultOfTheRoll := aDice roll.
	aBoard moveSpaceship: resultOfTheRoll.
	
	self deny: (game thereIsAWinner).
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testGameWithOneSpaceshipABoardWithFiveBoxesAndALoadedDieWithSixEndsAfterOneRoll [

	| aBoard aDice spaceship game resultOfTheRoll |
	spaceship := Spaceship assignedTo: 'APlayerName'.
	aBoard := Board withBoxes: 5 andSpaceship: spaceship.
	aDice := LoadedDie with: 6.
	
	game := OutstandingSpaceshipsGame withABoard: aBoard andDice: aDice.
	resultOfTheRoll := aDice roll.
	aBoard moveSpaceship: resultOfTheRoll.
	
	self assert: (game thereIsAWinner).
	
]

{ #category : #tests }
OutstandingSpaceshipsGameTest >> testGameWithTwoSpaceshipsABoardWithFiveBoxesAndALoadedDieWithThreeEnds [
	
	| aSpaceship anotherSpaceship aBoard aLoadedDie game resultOfTheRoll |
	aSpaceship := Spaceship assignedTo: 'Player1'.
	anotherSpaceship := Spaceship assignedTo: 'Player2'.
	aBoard := Board withBoxes: 5 andSpaceships: { aSpaceship. anotherSpaceship }.
	aLoadedDie := LoadedDie with: 3.
	game := OutstandingSpaceshipsGame withABoard: aBoard andDice: aLoadedDie.
	
	resultOfTheRoll := aLoadedDie roll.
	aBoard moveSpaceship: resultOfTheRoll.
	aBoard moveSpaceship: resultOfTheRoll.
	aBoard moveSpaceship: resultOfTheRoll.
	
	self assert: (game thereIsAWinner).
]

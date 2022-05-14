Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
BoardTest >> should: block raise: expectedErrorClass withMessage: expectedErrorMessaje [

	self
		should: block
		raise: expectedErrorClass
		whoseDescriptionIncludes: expectedErrorMessaje
		description: 'Test did not fail as expected'
]

{ #category : #tests }
BoardTest >> testASpaceshipCannotPlayWhenItIsNotItsTurn [

	| spaceship1 spaceship2 spaceship3 board |
	spaceship1 := Spaceship called: 'SP1'.
	spaceship2 := Spaceship called: 'SP2'.
	spaceship3 := Spaceship called: 'SP3'.
	board := Board of: 15 playedByMany: { 
			         spaceship1.
			         spaceship2.
			         spaceship3 }.
	board moveSpaceship: 1.
	board moveSpaceship: 1.
	self
		should: [ board moveSpaceshipOf: spaceship1 name by: 15 ]
		raise: Error
		withMessage: 'This is not the players turn'
]

{ #category : #tests }
BoardTest >> testASpaceshipThatLandsOnANormalBoxDoesntMove [

	| spaceship board |
	spaceship := Spaceship called: 'SP1'.
	board := Board of: 10 playedBy: spaceship.
	board moveSpaceshipOf: spaceship name by: 1.

	self assert: (board positionOf: spaceship name) equals: 1
]

{ #category : #tests }
BoardTest >> testASpaceshipThatLandsOnASpeedUpBoxEndsUpFourBoxesAfter [
	
	| spaceship board normalBox speedUpBox boxSequence box1 box2 box3 box4 box5 |
	spaceship := Spaceship called: 'SP1'.
	normalBox := NormalBox new.
	speedUpBox := SpeedUpBox new.

	box1 := Box withEffect: speedUpBox.
	box2 := Box withEffect: normalBox.
	box3 := Box withEffect: normalBox.
	box4 := Box withEffect: normalBox.
	box5 := Box withEffect: normalBox.
	
	boxSequence := { box1. box2. box3. box4. box5 }.
	board := Board of: 10 playedBy: spaceship andA: boxSequence .
	board moveSpaceshipOf: spaceship name by: 1.

	self assert: (board positionOf: spaceship name) equals: 5
]

{ #category : #tests }
BoardTest >> testASpaceshipsPositionVariesInFiveWithAFiniteBoardAfterOneRollOfALoadedDieWithFive [

	| n spaceshipName spaceship board loadedDie resultOfTheRoll |
	n := 10.
	spaceshipName := 'aPlayer'.
	spaceship := Spaceship called: spaceshipName.
	board := Board of: n playedBy: spaceship.
	loadedDie := LoadedDie with: 5.
	resultOfTheRoll := loadedDie roll.
	board moveSpaceshipOf: spaceshipName by: resultOfTheRoll.
	self assert: (board positionOf: spaceshipName) equals: resultOfTheRoll
]

{ #category : #tests }
BoardTest >> testBoardCannotBeCreatedWithANumberOfBoxesMinorThanOne [

	| spaceship |
	spaceship := Spaceship called: 'player'.
	self
		should: [ Board of: -5 playedBy: spaceship ]
		raise: Error
		withMessage: 'Number of boxes should be greater than zero'
]

{ #category : #tests }
BoardTest >> testBoardCannotBeCreatedWithMoreThanOneSpaceshipAssignedToTheSamePlayer [

	| aSpaceship anotherSpaceship otherSpaceship |
	aSpaceship := Spaceship called: 'player1'.
	anotherSpaceship := Spaceship called: 'player1'.
	otherSpaceship := Spaceship called: 'player3'.
	self
		should: [ 
			Board of: 15 playedByMany: { 
					aSpaceship.
					anotherSpaceship.
					otherSpaceship } ]
		raise: Error
		withMessage: 'Spaceships must be assigned to different players'
]

{ #category : #tests }
BoardTest >> testBoardCannotBeCreatedWithoutSpaceships [

	self
		should: [ Board of: 1 playedByMany: {  } ]
		raise: Error
		withMessage: 'Must use at least one spaceship'
]

{ #category : #tests }
BoardTest >> testBoardWithAHundredBoxesHasFourtyNormalBoxes [
	
	| spaceship board |
	spaceship := Spaceship called: 'SP1'.
	board := Board of: 100 playedBy: spaceship.
	
	self assert: board amountOfNormalBoxes equals: 40
]

{ #category : #tests }
BoardTest >> testSpaceshipLandsOnAtomicBombBoxSetsBackEveryoneToFirstBox [
	
	| spaceship anotherSpaceship board normalBox moonWalkBox boxSequence box1 box2 box3 box4 box5 atomicBombBox |
	spaceship := Spaceship called: 'SP1'.
	anotherSpaceship := Spaceship called: 'SP2'.
	normalBox := NormalBox new.
	atomicBombBox := AtomicBombBox new.

	box1 := Box withEffect: normalBox.
	box2 := Box withEffect: normalBox .
	box3 := Box withEffect: normalBox.
	box4 := Box withEffect: normalBox.
	box5 := Box withEffect: atomicBombBox.
	
	boxSequence := { box1. box2. box3. box4. box5 }.
	board := Board of: 10 playedByMany: {spaceship. anotherSpaceship} andA: boxSequence.
	board moveSpaceship: 3.
	board moveSpaceship: 2.
	board moveSpaceship: 2.
	
	self assert: (board positionOf: spaceship name) equals: 1.
	self assert: (board positionOf: anotherSpaceship name) equals: 1.
	


]

{ #category : #tests }
BoardTest >> testSpaceshipLandsOnMoonWalkBoxSetsBackOtherSpaceshipsExceptItself [
	
	| spaceship anotherSpaceship board normalBox moonWalkBox boxSequence box1 box2 box3 box4 box5 |
	spaceship := Spaceship called: 'SP1'.
	anotherSpaceship := Spaceship called: 'SP2'.
	normalBox := NormalBox new.
	moonWalkBox := MoonWalkBox displacing: 1.

	box1 := Box withEffect: normalBox.
	box2 := Box withEffect: moonWalkBox  .
	box3 := Box withEffect: normalBox.
	box4 := Box withEffect: normalBox.
	box5 := Box withEffect: normalBox.
	
	boxSequence := { box1. box2. box3. box4. box5 }.
	board := Board of: 10 playedByMany: {spaceship. anotherSpaceship} andA: boxSequence.
	board moveSpaceship: 3.
	board moveSpaceship: 2.
	
	self assert: (board positionOf: spaceship name) equals: 2.
	self assert: (board positionOf: anotherSpaceship name) equals: 2.
	board moveSpaceship: 7.
	self assert: (board positionOf: anotherSpaceship name) equals: 9.



]

{ #category : #tests }
BoardTest >> testSpaceshipLandsOnWormHoleBoxSetsBackItselfFourBoxes [
	
	| spaceship  board normalBox wormHoleBox boxSequence box1 box2 box3 box4 box5 |
	spaceship := Spaceship called: 'SP1'.
	normalBox := NormalBox new.
	wormHoleBox := WormHoleBox new.

	box1 := Box withEffect: normalBox.
	box2 := Box withEffect: normalBox.
	box3 := Box withEffect: normalBox.
	box4 := Box withEffect: normalBox.
	box5 := Box withEffect: wormHoleBox.
	
	boxSequence := { box1. box2. box3. box4. box5 }.
	board := Board of: 10 playedBy: spaceship andA: boxSequence.
	board moveSpaceship: 3.
	board moveSpaceship: 2.
	
	self assert: (board positionOf: spaceship name) equals: 1.
	


]

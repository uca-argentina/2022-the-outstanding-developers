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
BoardTest >> testABoardOfFifteenBoxesCreatedWithAShorterSequenceHasTheHardcodedAmountOfRepeatedBoxes [

	| enterprise board boxSequence aNormalBox aSpeedUpBox aWormHoleBox aMoonWalkBox aHyperJumpBox anAtomicBombBox |
	enterprise := Spaceship called: 'enterprise'.
	aNormalBox := Box withEffect: NormalBox new.
	aSpeedUpBox := Box withEffect: SpeedUpBox new.
	aWormHoleBox := Box withEffect: WormHoleBox new.
	aMoonWalkBox := Box withEffect: (MoonWalkBox displacing: 1).
	aHyperJumpBox := Box withEffect: (HyperJump with: { 1 }).
	anAtomicBombBox := Box withEffect: AtomicBombBox new.
	boxSequence := { aNormalBox. aSpeedUpBox. aWormHoleBox. aMoonWalkBox. aHyperJumpBox. anAtomicBombBox  }.
	board := Board of: 15 andLength: 15 for: 1 playedBy: enterprise andA: boxSequence .
	self assert: board amountOfBoxes equals: 15.
	self assert: board amountOfNormalBoxes equals: 3.
	self assert: board amountOfSpeedUpBoxes equals: 3.
	self assert: board amountOfWormHoleBoxes equals: 3.
	self assert: board amountOfMoonWalkBoxes equals: 2.
	self assert: board amountOfHyperJumpBoxes equals: 2.
	self assert: board amountOfAtomicBombBoxes equals: 2.
]

{ #category : #tests }
BoardTest >> testABoardOfOneHundredRandomGeneratedBoxesHasOneHundredBoxes [

	| n parsecs enterprise board distributions |
	n := 100.
	parsecs := 100.
	enterprise := Spaceship called: 'enterprise'.
	distributions := OrderedCollection new.
	distributions add: (Distribution withProbabilityOf: 0.4 for: NormalBox).
	distributions add: (Distribution withProbabilityOf: 0.2 for: SpeedUpBox).
	distributions add: (Distribution withProbabilityOf: 0.2 for: WormHoleBox).
	distributions add: (Distribution withProbabilityOf: 0.1 for: (MoonWalkBox for: n)).
	distributions add: (Distribution withProbabilityOf: 0.08 for: (HyperJump for: n upTo: parsecs)).
	distributions add: (Distribution withProbabilityOf: 0.02 for: (AtomicBombBox)).
		
	board := Board
		         of: n
		         andLength: parsecs
		         for: 1
		         playedBy: enterprise
		         distributed: distributions.
	self assert: board amountOfBoxes equals: 100
]

{ #category : #tests }
BoardTest >> testABoardOfTenBoxesCreatedWithASequenceHasTheHardcodedAmountOfBoxes [

	| enterprise board boxSequence aNormalBox aSpeedUpBox aWormHoleBox aMoonWalkBox aHyperJumpBox anAtomicBombBox |
	enterprise := Spaceship called: 'enterprise'.
	aNormalBox := Box withEffect: NormalBox new.
	aSpeedUpBox := Box withEffect: SpeedUpBox new.
	aWormHoleBox := Box withEffect: WormHoleBox new.
	aMoonWalkBox := Box withEffect: (MoonWalkBox displacing: 1).
	aHyperJumpBox := Box withEffect: (HyperJump with: { 1 }).
	anAtomicBombBox := Box withEffect: AtomicBombBox new.
	boxSequence := { 
		               aNormalBox.
		               aNormalBox.
		               aSpeedUpBox.
		               aWormHoleBox.
		               aMoonWalkBox.
		               aSpeedUpBox.
		               aHyperJumpBox.
		               anAtomicBombBox.
		               anAtomicBombBox.
		               anAtomicBombBox }.
	board := Board
		         of: 10
		         andLength: 10
		         for: 1
		         playedBy: enterprise
		         andA: boxSequence.
	self assert: board amountOfBoxes equals: 10.
	self assert: board amountOfNormalBoxes equals: 2.
	self assert: board amountOfSpeedUpBoxes equals: 2.
	self assert: board amountOfWormHoleBoxes equals: 1.
	self assert: board amountOfMoonWalkBoxes equals: 1.
	self assert: board amountOfHyperJumpBoxes equals: 1.
	self assert: board amountOfAtomicBombBoxes equals: 3
]

{ #category : #tests }
BoardTest >> testASpaceshipCannotPlayWhenItIsNotItsTurn [

	| distributions spaceship1 spaceship2 spaceship3 board n parsecs |
	n := 100.
	parsecs := 100.
	spaceship1 := Spaceship called: 'SP1'.
	spaceship2 := Spaceship called: 'SP2'.
	spaceship3 := Spaceship called: 'SP3'.
	distributions := OrderedCollection new.
	distributions add: (Distribution withProbabilityOf: 1 for: NormalBox).
	board := Board of: n andLength: parsecs for: 1 playedByMany: { 
			         spaceship1.
			         spaceship2.
			         spaceship3 } distributed: distributions.
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
	board := Board of: 10 for: 1 playedBy: spaceship andA: {Box withEffect: NormalBox new}.
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

	boxSequence := { 
		               box1.
		               box2.
		               box3.
		               box4.
		               box5 }.
	board := Board
		         of: 10
		         for: 1
		         playedBy: spaceship
		         andA: boxSequence.
	board moveSpaceshipOf: spaceship name by: 1.

	self assert: (board positionOf: spaceship name) equals: 5
]

{ #category : #tests }
BoardTest >> testASpaceshipsLapPositionVariesToTwoAfterCompletingFirstLap [

	| spaceshipName spaceship board loadedDie resultOfTheRoll |
	spaceshipName := 'Player1'.
	spaceship := Spaceship called: spaceshipName.
	board := Board
		         of: 10
		         for: 2
		         playedBy: spaceship
		         andA: { (Box withEffect: NormalBox new) }.
	loadedDie := LoadedDie with: 5.
	resultOfTheRoll := loadedDie roll.
	board moveSpaceshipOf: spaceshipName by: resultOfTheRoll.
	board moveSpaceshipOf: spaceshipName by: resultOfTheRoll.
	board moveSpaceshipOf: spaceshipName by: resultOfTheRoll.
	self assert: (board lapOf: spaceshipName) equals: 2
]

{ #category : #tests }
BoardTest >> testASpaceshipsPositionVariesInFiveWithAFiniteBoardAfterOneRollOfALoadedDieWithFive [

	| n spaceshipName spaceship board loadedDie resultOfTheRoll |
	n := 10.
	spaceshipName := 'aPlayer'.
	spaceship := Spaceship called: spaceshipName.
	board := Board of: n for: 1 playedBy: spaceship andA: {Box withEffect: NormalBox new}.
	loadedDie := LoadedDie with: 5.
	resultOfTheRoll := loadedDie roll.
	board moveSpaceshipOf: spaceshipName by: resultOfTheRoll.
	self
		assert: (board positionOf: spaceshipName)
		equals: resultOfTheRoll
]

{ #category : #tests }
BoardTest >> testBoardCannotBeCreatedWithALegthMinorThanTheNumberOfBoxes [

	| spaceship distributions |
	spaceship := Spaceship called: 'player'.
	distributions := OrderedCollection new.
	distributions add: (Distribution withProbabilityOf: 1 for: NormalBox).
	
	self
		should: [ 
			Board
				of: 10
				andLength: 8
				for: 1
				playedBy: spaceship
				distributed: distributions ]
		raise: Error
		withMessage:
		'Board length should be greater or equal to number of boxes'
]

{ #category : #tests }
BoardTest >> testBoardCannotBeCreatedWithANegativeLegth [

	| spaceship distributions |
	spaceship := Spaceship called: 'player'.
	distributions := OrderedCollection new.
	distributions add: (Distribution withProbabilityOf: 1 for: NormalBox).

	self
		should: [ 
			Board
				of: 10
				andLength: -10
				for: 1
				playedBy: spaceship
				distributed: distributions ]
		raise: Error
		withMessage: 'Board length should be greater than zero'
]

{ #category : #tests }
BoardTest >> testBoardCannotBeCreatedWithANumberOfBoxesMinorThanOne [

	| spaceship distributions |
	spaceship := Spaceship called: 'player'.
	distributions := OrderedCollection new.
	distributions add: (Distribution withProbabilityOf: 1 for: NormalBox).
	
	self
		should: [ 
			Board
				of: -5
				andLength: 10
				for: 1
				playedBy: spaceship
				distributed: distributions ]
		raise: Error
		withMessage: 'Number of boxes should be greater than zero'
]

{ #category : #tests }
BoardTest >> testBoardCannotBeCreatedWithANumberOfLapsMinorThanOne [

	| spaceship distributions |
	spaceship := Spaceship called: 'player'.
	distributions := OrderedCollection new.
	distributions add: (Distribution withProbabilityOf: 1 for: NormalBox).

	self
		should: [ 
			Board
				of: 15
				andLength: 10
				for: -1
				playedBy: spaceship
				distributed: distributions ]
		raise: Error
		withMessage: 'Number of laps should be greater than zero'
]

{ #category : #tests }
BoardTest >> testBoardCannotBeCreatedWithMoreThanOneSpaceshipAssignedToTheSamePlayer [

	| aSpaceship anotherSpaceship otherSpaceship distributions |
	aSpaceship := Spaceship called: 'player1'.
	anotherSpaceship := Spaceship called: 'player1'.
	otherSpaceship := Spaceship called: 'player3'.
	distributions := OrderedCollection new.
	distributions add: (Distribution withProbabilityOf: 1 for: NormalBox).

	self
		should: [ 
			Board
				of: 15
				andLength: 10
				for: 1
				playedByMany: { 
						aSpaceship.
						anotherSpaceship.
						otherSpaceship }
				distributed: distributions ]
		raise: Error
		withMessage: 'Spaceships must be assigned to different players'
]

{ #category : #tests }
BoardTest >> testBoardCannotBeCreatedWithoutSpaceships [

	| distributions |
	distributions := OrderedCollection new.
	distributions add: (Distribution withProbabilityOf: 1 for: NormalBox).

	self
		should: [ 
			Board
				of: 10
				andLength: 10
				for: 1
				playedByMany: {  }
				distributed: distributions ]
		raise: Error
		withMessage: 'Must use at least one spaceship'
]

{ #category : #tests }
BoardTest >> testBoardCreatedWithTenBoxesAndALengthOfTwoHundredParsecsHasBoxesLengthOfTen [

	| distributions spaceship board |
	distributions := OrderedCollection new.
	distributions add: (Distribution withProbabilityOf: 1 for: NormalBox).
	spaceship := Spaceship called: 'player'.
	board := Board
		         of: 10
		         andLength: 200
		         for: 1
		         playedBy: spaceship
		         distributed: distributions.
	self assert: board boxLength equals: 20
]

{ #category : #tests }
BoardTest >> testSpaceshipLandsOnAtomicBombBoxSetsBackEveryoneToFirstBox [

	| spaceship anotherSpaceship board normalBox boxSequence box1 box2 box3 box4 box5 atomicBombBox otherSpaceship |
	spaceship := Spaceship called: 'SP1'.
	anotherSpaceship := Spaceship called: 'SP2'.
	otherSpaceship := Spaceship called: 'SP3'.
	normalBox := NormalBox new.
	atomicBombBox := AtomicBombBox new.

	box1 := Box withEffect: normalBox.
	box2 := Box withEffect: normalBox.
	box3 := Box withEffect: normalBox.
	box4 := Box withEffect: normalBox.
	box5 := Box withEffect: atomicBombBox.

	boxSequence := { 
		               box1.
		               box2.
		               box3.
		               box4.
		               box5 }.
	board := Board
		         of: 10
		         for: 1
		         playedByMany: { 
				         spaceship.
				         anotherSpaceship.
				         otherSpaceship }
		         andA: boxSequence.
	board moveSpaceship: 3.
	board moveSpaceship: 2.
	board moveSpaceship: 1.
	board moveSpaceship: 2.

	self assert: (board positionOf: spaceship name) equals: 1.
	self assert: (board positionOf: anotherSpaceship name) equals: 1.
	self assert: (board positionOf: otherSpaceship name) equals: 1
]

{ #category : #tests }
BoardTest >> testSpaceshipLandsOnMoonWalkBoxSetsBackOtherSpaceshipsExceptItself [

	| spaceship anotherSpaceship board normalBox moonWalkBox boxSequence box1 box2 box3 box4 box5 |
	spaceship := Spaceship called: 'SP1'.
	anotherSpaceship := Spaceship called: 'SP2'.
	normalBox := NormalBox new.
	moonWalkBox := MoonWalkBox displacing: 1.

	box1 := Box withEffect: normalBox.
	box2 := Box withEffect: moonWalkBox.
	box3 := Box withEffect: normalBox.
	box4 := Box withEffect: normalBox.
	box5 := Box withEffect: normalBox.

	boxSequence := { 
		               box1.
		               box2.
		               box3.
		               box4.
		               box5 }.
	board := Board
		         of: 10
		         for: 1
		         playedByMany: { 
				         spaceship.
				         anotherSpaceship }
		         andA: boxSequence.
	board moveSpaceship: 3.
	board moveSpaceship: 2.

	self assert: (board positionOf: spaceship name) equals: 2.
	self assert: (board positionOf: anotherSpaceship name) equals: 2
]

{ #category : #tests }
BoardTest >> testSpaceshipLandsOnWormHoleBoxSetsBackItselfFourBoxes [

	| spaceship board normalBox wormHoleBox boxSequence box1 box2 box3 box4 box5 |
	spaceship := Spaceship called: 'SP1'.
	normalBox := NormalBox new.
	wormHoleBox := WormHoleBox new.

	box1 := Box withEffect: normalBox.
	box2 := Box withEffect: normalBox.
	box3 := Box withEffect: normalBox.
	box4 := Box withEffect: normalBox.
	box5 := Box withEffect: wormHoleBox.

	boxSequence := { 
		               box1.
		               box2.
		               box3.
		               box4.
		               box5 }.
	board := Board
		         of: 10
		         for: 2
		         playedBy: spaceship
		         andA: boxSequence.
	board moveSpaceship: 3.
	board moveSpaceship: 2.

	self assert: (board positionOf: spaceship name) equals: 1
]

{ #category : #tests }
BoardTest >> testSpaceshipThatLandsOnMoonWalkBoxCantMakeOthersGoToNegativePositions [

	| spaceship board normalBox moonWalkBox boxSequence box1 box2 box3 box4 box5 anotherSpaceship |
	spaceship := Spaceship called: 'SP1'.
	anotherSpaceship := Spaceship called: 'SP2'.
	normalBox := NormalBox new.
	moonWalkBox := MoonWalkBox displacing: 10.

	box1 := Box withEffect: moonWalkBox.
	box2 := Box withEffect: normalBox.
	box3 := Box withEffect: normalBox.
	box4 := Box withEffect: normalBox.
	box5 := Box withEffect: normalBox.

	boxSequence := { 
		               box1.
		               box2.
		               box3.
		               box4.
		               box5 }.
	board := Board
		         of: 10
		         for: 2
		         playedByMany: { 
				         spaceship.
				         anotherSpaceship }
		         andA: boxSequence.
	board moveSpaceship: 5.
	board moveSpaceship: 1.

	self assert: (board positionOf: spaceship name) equals: 1.
	self assert: (board positionOf: anotherSpaceship name) equals: 1
]

{ #category : #tests }
BoardTest >> testSpaceshipThatLandsOnWormHoleBoxCantGoToNegativePositions [

	| spaceship board normalBox wormHoleBox boxSequence box1 box2 box3 box4 box5 |
	spaceship := Spaceship called: 'SP1'.
	normalBox := NormalBox new.
	wormHoleBox := WormHoleBox new.

	box1 := Box withEffect: wormHoleBox.
	box2 := Box withEffect: normalBox.
	box3 := Box withEffect: normalBox.
	box4 := Box withEffect: normalBox.
	box5 := Box withEffect: normalBox.

	boxSequence := { 
		               box1.
		               box2.
		               box3.
		               box4.
		               box5 }.
	board := Board
		         of: 10
		         for: 2
		         playedBy: spaceship
		         andA: boxSequence.
	board moveSpaceship: 1.

	self assert: (board positionOf: spaceship name) equals: 1
]

{ #category : #tests }
BoardTest >> testSpaceshipsThatLandsOnAHyperJumpBoxEndUpFiveBoxesAfterThenFourBoxesAfter [

	| board normalBox hyperJumpBox boxSequence box1 box2 box3 box4 box5 aSpaceship anotherSpaceship |
	aSpaceship := Spaceship called: 'SP1'.
	anotherSpaceship := Spaceship called: 'SP2'.
	normalBox := NormalBox new.
	hyperJumpBox := HyperJump with: { 10. 8 }.

	box1 := Box withEffect: hyperJumpBox.
	box2 := Box withEffect: normalBox.
	box3 := Box withEffect: normalBox.
	box4 := Box withEffect: normalBox.
	box5 := Box withEffect: normalBox.

	boxSequence := { 
		               box1.
		               box2.
		               box3.
		               box4.
		               box5 }.
	board := Board
		         of: 10
		         andLength: 20
		         for: 1
		         playedByMany: { 
				         aSpaceship.
				         anotherSpaceship }
		         andA: boxSequence.
	board moveSpaceship: 1.
	board moveSpaceship: 1.

	self assert: (board positionOf: aSpaceship name) equals: 6.
	self assert: (board positionOf: anotherSpaceship name) equals: 5.

	board moveSpaceship: 1.
	board moveSpaceship: 1.
	self assert: (board positionOf: aSpaceship name) equals: 7.
	self assert: (board positionOf: anotherSpaceship name) equals: 11
]

{ #category : #tests }
BoardTest >> testSpaceshipsThatLandsOnAHyperJumpBoxEndUpFiveBoxesAfterThenFourBoxesAfterWithFloatingLengths [

	| board normalBox hyperJumpBox boxSequence box1 box2 box3 box4 box5 aSpaceship anotherSpaceship |
	aSpaceship := Spaceship called: 'SP1'.
	anotherSpaceship := Spaceship called: 'SP2'.
	normalBox := NormalBox new.
	hyperJumpBox := HyperJump with: { 14. 13 }.

	box1 := Box withEffect: hyperJumpBox.
	box2 := Box withEffect: normalBox.
	box3 := Box withEffect: normalBox.
	box4 := Box withEffect: normalBox.
	box5 := Box withEffect: normalBox.

	boxSequence := { 
		               box1.
		               box2.
		               box3.
		               box4.
		               box5 }.
	board := Board
		         of: 15
		         andLength: 100
		         for: 1
		         playedByMany: { 
				         aSpaceship.
				         anotherSpaceship }
		         andA: boxSequence.
	board moveSpaceship: 1.
	board moveSpaceship: 1.

	self assert: (board positionOf: aSpaceship name) equals: 3.
	self assert: (board positionOf: anotherSpaceship name) equals: 2
]

{ #category : #tests }
BoardTest >> testSpeedUpDoesntTriggerAnotherSpeedUp [

	| spaceship board normalBox speedUpBox box |
	spaceship := Spaceship called: 'SP1'.
	normalBox := NormalBox new.
	speedUpBox := SpeedUpBox new.

	box := Box withEffect: speedUpBox.

	board := Board
		         of: 10
		         for: 1
		         playedBy: spaceship
		         andA: { box }.
	board moveSpaceshipOf: spaceship name by: 1.

	self assert: (board positionOf: spaceship name) equals: 5
]

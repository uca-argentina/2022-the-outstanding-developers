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
	aNormalBox := Box with: NoEffect new.
	aSpeedUpBox := Box with: SpeedUpEffect new.
	aWormHoleBox := Box with: WormHoleEffect new.
	aMoonWalkBox := Box with: (MoonWalkEffect displacing: 1).
	aHyperJumpBox := Box with: (HyperJumpEffect with: { 1 }).
	anAtomicBombBox := Box with: AtomicBombEffect new.
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
	distributions add:
		(Distribution withProbabilityOf: 0.4 for: NoEffect).
	distributions add:
		(Distribution withProbabilityOf: 0.2 for: SpeedUpEffect).
	distributions add:
		(Distribution withProbabilityOf: 0.2 for: WormHoleEffect).
	distributions add:
		(Distribution withProbabilityOf: 0.1 for: (MoonWalkEffect for: n)).
	distributions add: (Distribution
			 withProbabilityOf: 0.08
			 for: (HyperJumpEffect for: n upTo: parsecs)).
	distributions add:
		(Distribution withProbabilityOf: 0.02 for: AtomicBombEffect).

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
	aNormalBox := Box with: NoEffect new.
	aSpeedUpBox := Box with: SpeedUpEffect new.
	aWormHoleBox := Box with: WormHoleEffect new.
	aMoonWalkBox := Box with: (MoonWalkEffect displacing: 1).
	aHyperJumpBox := Box with: (HyperJumpEffect with: { 1 }).
	anAtomicBombBox := Box with: AtomicBombEffect new.
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
	distributions add: (Distribution withProbabilityOf: 1 for: NoEffect).
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
	board := Board of: 10 for: 1 playedBy: spaceship andA: {Box with: NoEffect new}.
	board moveSpaceshipOf: spaceship name by: 1.

	self assert: (board positionOf: spaceship name) equals: 1
]

{ #category : #tests }
BoardTest >> testASpaceshipThatLandsOnASpeedUpBoxEndsUpFourBoxesAfter [

	| spaceship board normalBox speedUpBox boxSequence box1 box2 box3 box4 box5 |
	spaceship := Spaceship called: 'SP1'.
	normalBox := NoEffect new.
	speedUpBox := SpeedUpEffect new.

	box1 := Box with: speedUpBox.
	box2 := Box with: normalBox.
	box3 := Box with: normalBox.
	box4 := Box with: normalBox.
	box5 := Box with: normalBox.

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
		         andA: { (Box with: NoEffect new) }.
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
	board := Board of: n for: 1 playedBy: spaceship andA: {Box with: NoEffect new}.
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
	distributions add: (Distribution withProbabilityOf: 1 for: NoEffect).
	
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
	distributions add: (Distribution withProbabilityOf: 1 for: NoEffect).

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
	distributions add: (Distribution withProbabilityOf: 1 for: NoEffect).
	
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
	distributions add: (Distribution withProbabilityOf: 1 for: NoEffect).

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
	distributions add: (Distribution withProbabilityOf: 1 for: NoEffect).

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
	distributions add: (Distribution withProbabilityOf: 1 for: NoEffect).

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
	distributions add: (Distribution withProbabilityOf: 1 for: NoEffect).
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
BoardTest >> testPlayersInDifferentLapsReturnToTheFirstBoxOfItsLaps [

	| spaceship anotherSpaceship board noEffect boxSequence box1 box2 box3 box4 box5 atomicBombEffect otherSpaceship |
	spaceship := Spaceship called: 'SP1'.
	anotherSpaceship := Spaceship called: 'SP2'.
	otherSpaceship := Spaceship called: 'SP3'.
	noEffect := NoEffect new.
	atomicBombEffect := AtomicBombEffect new.

	box1 := Box with: noEffect.
	box2 := Box with: noEffect.
	box3 := Box with: noEffect.
	box4 := Box with: noEffect.
	box5 := Box with: atomicBombEffect.

	boxSequence := { 
		               box1.
		               box2.
		               box3.
		               box4.
		               box5 }.

	board := Board
		         of: 5
		         for: 3
		         playedByMany: { 
				         spaceship.
				         anotherSpaceship.
				         otherSpaceship }
		         andA: boxSequence.
	board moveSpaceship: 6. "Avanza toda una vuelta"
	board moveSpaceship: 6. "Avanza toda una vuelta"
	board moveSpaceship: 1.

	board moveSpaceship: 6. "Avanza otra vuelta mas"
	board moveSpaceship: 1. "Lo muevo un poquito"
	board moveSpaceship: 1.

	board moveSpaceship: 2. "Lo dejo en una posición"
	board moveSpaceship: 1. "Lo muevo un poco mas"

	self assert: (board positionOf: spaceship name) equals: 3.
	self assert: (board lapOf: spaceship name) equals: 3.

	self assert: (board positionOf: anotherSpaceship name) equals: 3.
	self assert: (board lapOf: anotherSpaceship name) equals: 2.

	self assert: (board positionOf: otherSpaceship name) equals: 2.
	self assert: (board lapOf: otherSpaceship name) equals: 1.

	board moveSpaceship: 3. "Lo hago caer en el AtomicBomb"

	self assert: (board positionOf: spaceship name) equals: 1.
	self assert: (board lapOf: spaceship name) equals: 3.

	self assert: (board positionOf: anotherSpaceship name) equals: 1.
	self assert: (board lapOf: anotherSpaceship name) equals: 2.

	self assert: (board positionOf: otherSpaceship name) equals: 1.
	self assert: (board lapOf: otherSpaceship name) equals: 1
]

{ #category : #tests }
BoardTest >> testSpaceshipLandsOnAtomicBombBoxSetsBackEveryoneToFirstBox [

	| spaceship anotherSpaceship board noEffect boxSequence box1 box2 box3 box4 box5 anEffect otherSpaceship |
	spaceship := Spaceship called: 'SP1'.
	anotherSpaceship := Spaceship called: 'SP2'.
	otherSpaceship := Spaceship called: 'SP3'.
	noEffect := NoEffect new.
	anEffect := AtomicBombEffect new.

	box1 := Box with: noEffect.
	box2 := Box with: noEffect.
	box3 := Box with: noEffect.
	box4 := Box with: noEffect.
	box5 := Box with: anEffect.

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

	| spaceship anotherSpaceship board noEffect anEffect boxSequence box1 box2 box3 box4 box5 |
	spaceship := Spaceship called: 'SP1'.
	anotherSpaceship := Spaceship called: 'SP2'.
	noEffect := NoEffect new.
	anEffect := MoonWalkEffect displacing: 1.

	box1 := Box with: noEffect.
	box2 := Box with: anEffect.
	box3 := Box with: noEffect.
	box4 := Box with: noEffect.
	box5 := Box with: noEffect.

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

	| spaceship board noEffect anEffect boxSequence box1 box2 box3 box4 box5 |
	spaceship := Spaceship called: 'SP1'.
	noEffect := NoEffect new.
	anEffect := WormHoleEffect new.

	box1 := Box with: noEffect.
	box2 := Box with: noEffect.
	box3 := Box with: noEffect.
	box4 := Box with: noEffect.
	box5 := Box with: anEffect.

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

	| spaceship board noEffect anEffect boxSequence box1 box2 box3 box4 box5 anotherSpaceship |
	spaceship := Spaceship called: 'SP1'.
	anotherSpaceship := Spaceship called: 'SP2'.
	noEffect := NoEffect new.
	anEffect := MoonWalkEffect displacing: 10.

	box1 := Box with: anEffect.
	box2 := Box with: noEffect.
	box3 := Box with: noEffect.
	box4 := Box with: noEffect.
	box5 := Box with: noEffect.

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

	| spaceship board noEffect anEffect boxSequence box1 box2 box3 box4 box5 |
	spaceship := Spaceship called: 'SP1'.
	noEffect := NoEffect new.
	anEffect := WormHoleEffect new.

	box1 := Box with: anEffect.
	box2 := Box with: noEffect.
	box3 := Box with: noEffect.
	box4 := Box with: noEffect.
	box5 := Box with: noEffect.

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

	| board noEffect anEffect boxSequence box1 box2 box3 box4 box5 aSpaceship anotherSpaceship |
	aSpaceship := Spaceship called: 'SP1'.
	anotherSpaceship := Spaceship called: 'SP2'.
	noEffect := NoEffect new.
	anEffect := HyperJumpEffect with: { 10. 8 }.

	box1 := Box with: anEffect.
	box2 := Box with: noEffect.
	box3 := Box with: noEffect.
	box4 := Box with: noEffect.
	box5 := Box with: noEffect.

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

	| board noEffect anEffect boxSequence box1 box2 box3 box4 box5 aSpaceship anotherSpaceship |
	aSpaceship := Spaceship called: 'SP1'.
	anotherSpaceship := Spaceship called: 'SP2'.
	noEffect := NoEffect new.
	anEffect := HyperJumpEffect with: { 14. 13 }.

	box1 := Box with: anEffect.
	box2 := Box with: noEffect.
	box3 := Box with: noEffect.
	box4 := Box with: noEffect.
	box5 := Box with: noEffect.

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

	| spaceship board anEffect speedUpBox box |
	spaceship := Spaceship called: 'SP1'.
	anEffect := NoEffect new.
	speedUpBox := SpeedUpEffect new.

	box := Box with: speedUpBox.

	board := Board
		         of: 10
		         for: 1
		         playedBy: spaceship
		         andA: { box }.
	board moveSpaceshipOf: spaceship name by: 1.

	self assert: (board positionOf: spaceship name) equals: 5
]

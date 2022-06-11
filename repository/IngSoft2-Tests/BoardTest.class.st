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
	board := Board of: 15 and: 15 playedFor: 1 by: enterprise with: boxSequence .
	self assert: board amountOfBoxes equals: 15.
	self assert: board amountOfNoEffectBoxes equals: 3.
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
		         and: parsecs
		         playedFor: 1
		         by: enterprise
		         givenBy: distributions.
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
		         and: 10
		         playedFor: 1
		         by: enterprise
		         with: boxSequence.
	self assert: board amountOfBoxes equals: 10.
	self assert: board amountOfNoEffectBoxes equals: 2.
	self assert: board amountOfSpeedUpBoxes equals: 2.
	self assert: board amountOfWormHoleBoxes equals: 1.
	self assert: board amountOfMoonWalkBoxes equals: 1.
	self assert: board amountOfHyperJumpBoxes equals: 1.
	self assert: board amountOfAtomicBombBoxes equals: 3
]

{ #category : #tests }
BoardTest >> testASpaceshipCannotPlayWhenItIsNotItsTurn [

	| distributions enterprise zathura delorean board n parsecs |
	n := 100.
	parsecs := 100.
	enterprise := Spaceship called: 'Enterprise'.
	zathura := Spaceship called: 'Zathura'.
	delorean := Spaceship called: 'Delorean'.
	distributions := OrderedCollection new.
	distributions add: (Distribution withProbabilityOf: 1 for: NoEffect).
	board := Board of: n and: parsecs playedFor: 1 byMany: { 
			         enterprise.
			         zathura.
			         delorean } givenBy: distributions.
	board moveSpaceship: 1.
	board moveSpaceship: 1.
	self
		should: [ board move: enterprise name by: 15 ]
		raise: Error
		withMessage: 'This is not the players turn'
]

{ #category : #tests }
BoardTest >> testASpaceshipThatLandsOnANormalBoxDoesntMove [

	| enterprise board |
	enterprise := Spaceship called: 'Enterprise'.
	board := Board of: 10 and: 10 playedFor: 1 by: enterprise with: {Box with: NoEffect new}.
	board move: enterprise name by: 1.

	self assert: (board positionOf: enterprise name) equals: 1
]

{ #category : #tests }
BoardTest >> testASpaceshipThatLandsOnASpeedUpBoxEndsUpFourBoxesAfter [

	| enterprise board normalBox speedUpBox boxSequence box1 box2 box3 box4 box5 |
	enterprise := Spaceship called: 'SP1'.
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
					and: 10
		         playedFor: 1
		         by: enterprise
		         with: boxSequence.
	board move: enterprise name by: 1.

	self assert: (board positionOf: enterprise name) equals: 5
]

{ #category : #tests }
BoardTest >> testASpaceshipsLapPositionVariesToTwoAfterCompletingFirstLap [

	| enterprise board loadedDie resultOfTheRoll |
	enterprise := Spaceship called: 'Enterprise'.
	board := Board
		         of: 10
					and: 10
		         playedFor: 2
		         by: enterprise
		         with: { (Box with: NoEffect new) }.
	loadedDie := LoadedDie with: 5.
	resultOfTheRoll := loadedDie roll.
	board move: enterprise name by: resultOfTheRoll.
	board move: enterprise name by: resultOfTheRoll.
	board move: enterprise name by: resultOfTheRoll.
	self assert: (board lapOf: enterprise name) equals: 2
]

{ #category : #tests }
BoardTest >> testASpaceshipsPositionVariesInFiveWithAFiniteBoardAfterOneRollOfALoadedDieWithFive [

	| n enterprise board loadedDie resultOfTheRoll |
	n := 10.
	enterprise := Spaceship called: 'Enterprise'.
	board := Board of: n and: n playedFor: 1 by: enterprise with: {Box with: NoEffect new}.
	loadedDie := LoadedDie with: 5.
	resultOfTheRoll := loadedDie roll.
	board move: enterprise name by: resultOfTheRoll.
	self
		assert: (board positionOf: enterprise name)
		equals: resultOfTheRoll
]

{ #category : #tests }
BoardTest >> testBoardCannotBeCreatedWithANumberOfBoxesMinorThanOne [

	| zathura distributions |
	zathura := Spaceship called: 'Zathura'.
	distributions := OrderedCollection new.
	distributions add: (Distribution withProbabilityOf: 1 for: NoEffect).

	self
		should: [ 
			Board
				of: -5
				and: 10
				playedFor: 1
				by: zathura
				givenBy: distributions ]
		raise: Error
		withMessage: 'Number of boxes should be greater than zero'
]

{ #category : #tests }
BoardTest >> testBoardCannotBeCreatedWithANumberOfLapsMinorThanOne [

	| zathura distributions |
	zathura := Spaceship called: 'Zathura'.
	distributions := OrderedCollection new.
	distributions add: (Distribution withProbabilityOf: 1 for: NoEffect).

	self
		should: [ 
			Board
				of: 15
				and: 10
				playedFor: -1
				by: zathura
				givenBy: distributions ]
		raise: Error
		withMessage: 'Number of laps should be greater than zero'
]

{ #category : #tests }
BoardTest >> testBoardCannotBeCreatedWithMoreThanOneSpaceshipAssignedToTheSamePlayer [

	| enterprise zathura delorean distributions |
	enterprise := Spaceship called: 'Enterprise'.
	zathura := Spaceship called: 'Enterprise'.
	delorean := Spaceship called: 'Delorean'.
	distributions := OrderedCollection new.
	distributions add: (Distribution withProbabilityOf: 1 for: NoEffect).

	self
		should: [ 
			Board
				of: 15
				and: 10
				playedFor: 1
				byMany: { 
						enterprise.
						zathura.
						delorean }
				givenBy: distributions ]
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
				and: 10
				playedFor: 1
				byMany: {  }
				givenBy: distributions ]
		raise: Error
		withMessage: 'Must use at least one spaceship'
]

{ #category : #tests }
BoardTest >> testBoardCreatedWithTenBoxesAndALengthOfTwoHundredParsecsHasBoxesLengthOfTen [

	| distributions enterprise board aParsecUnit |
	distributions := OrderedCollection new.
	distributions add: (Distribution withProbabilityOf: 1 for: NoEffect).
	enterprise := Spaceship called: 'Enterprise'.
	aParsecUnit := ParsecUnit of: 200.
	board := Board
		         of: 10
		         and: aParsecUnit
		         playedFor: 1
		         by: enterprise
		         givenBy: distributions.
	self assert: board boxParsecLength equals: 20
]

{ #category : #tests }
BoardTest >> testBoardLengthCreatedInLigthYearsCanBeExpressedInParsecsOrLightYears [

	| distributions enterprise board aLightYearUnit |
	distributions := OrderedCollection new.
	distributions add: (Distribution withProbabilityOf: 1 for: NoEffect).
	enterprise := Spaceship called: 'Enterprise'.
	aLightYearUnit := LightYearUnit of: 30.
	board := Board
		         of: 10
		         and: aLightYearUnit
		         playedFor: 1
		         by: enterprise
		         givenBy: distributions.
	self assert: board boxParsecLength equals: 1.
	self assert: board boxLigthYearLength equals: 3
	
]

{ #category : #tests }
BoardTest >> testBoardLengthCreatedInParsecsCanBeExpressedInParsecsOrLightYears [

	| distributions enterprise board aParsecUnit |
	distributions := OrderedCollection new.
	distributions add: (Distribution withProbabilityOf: 1 for: NoEffect).
	aParsecUnit := ParsecUnit of: 200.
	enterprise := Spaceship called: 'Enterprise'.
	board := Board
		         of: 10
		         and: aParsecUnit
		         playedFor: 1
		         by: enterprise
		         givenBy: distributions.
	self assert: board boxParsecLength equals: 20.
	self assert: board boxLigthYearLength equals: 60
	
]

{ #category : #tests }
BoardTest >> testBoxesLengthIsAHalfWhenTheAmountOfParsecsIsHalfTheAmountOfBoxes [

	| zathura distributions board aParsecUnit |
	zathura := Spaceship called: 'Zathura'.
	distributions := OrderedCollection new.
	distributions add: (Distribution withProbabilityOf: 1 for: NoEffect).
	aParsecUnit := ParsecUnit of: 10.
	board := Board
		         of: 20
		         and: aParsecUnit
		         playedFor: 1
		         by: zathura
		         givenBy: distributions.

	self assert: board boxParsecLength equals: 0.5
]

{ #category : #tests }
BoardTest >> testPlayersInDifferentLapsReturnToTheFirstBoxOfItsLaps [

	| enterprise zathura board noEffect boxSequence box1 box2 box3 box4 box5 atomicBombEffect delorean |
	enterprise := Spaceship called: 'Enterprise'.
	zathura := Spaceship called: 'Zathura'.
	delorean := Spaceship called: 'Delorean'.
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
		         and: 5
		         playedFor: 3
		         byMany: { 
				         enterprise.
				         zathura.
				         delorean }
		         with: boxSequence.
	board moveSpaceship: 6.
	board moveSpaceship: 6.
	board moveSpaceship: 1.

	board moveSpaceship: 6.
	board moveSpaceship: 1.
	board moveSpaceship: 1.

	board moveSpaceship: 2.
	board moveSpaceship: 1.

	self assert: (board positionOf: enterprise name) equals: 3.
	self assert: (board lapOf: enterprise name) equals: 3.

	self assert: (board positionOf: zathura name) equals: 3.
	self assert: (board lapOf: zathura name) equals: 2.

	self assert: (board positionOf: delorean name) equals: 2.
	self assert: (board lapOf: delorean name) equals: 1.

	board moveSpaceship: 3.

	self assert: (board positionOf: enterprise name) equals: 1.
	self assert: (board lapOf: enterprise name) equals: 3.

	self assert: (board positionOf: zathura name) equals: 1.
	self assert: (board lapOf: zathura name) equals: 2.

	self assert: (board positionOf: delorean name) equals: 1.
	self assert: (board lapOf: delorean name) equals: 1
]

{ #category : #tests }
BoardTest >> testSpaceshipLandsOnAtomicBombBoxSetsBackEveryoneToFirstBox [

	| enterprise zathura board noEffect boxSequence box1 box2 box3 box4 box5 anEffect delorean |
	enterprise := Spaceship called: 'Enterprise'.
	zathura := Spaceship called: 'Zathura'.
	delorean := Spaceship called: 'Delorean'.
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
		         and: 10
		         playedFor: 1
		         byMany: { 
				         enterprise.
				         zathura.
				         delorean }
		         with: boxSequence.
	board moveSpaceship: 3.
	board moveSpaceship: 2.
	board moveSpaceship: 1.
	board moveSpaceship: 2.

	self assert: (board positionOf: enterprise name) equals: 1.
	self assert: (board positionOf: zathura name) equals: 1.
	self assert: (board positionOf: delorean name) equals: 1.
	self assert: (board lapOf: enterprise name) equals: 1.
	self assert: (board lapOf: zathura name) equals: 1.
	self assert: (board lapOf: delorean name) equals: 1
]

{ #category : #tests }
BoardTest >> testSpaceshipLandsOnMoonWalkBoxSetsBackOtherSpaceshipsExceptItself [

	| enterprise zathura board noEffect anEffect boxSequence box1 box2 box3 box4 box5 |
	enterprise := Spaceship called: 'Enterprise'.
	zathura := Spaceship called: 'Zathura'.
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
		         and: 10
		         playedFor: 1
		         byMany: { 
				         enterprise.
				         zathura }
		         with: boxSequence.
	board moveSpaceship: 3.
	board moveSpaceship: 2.

	self assert: (board positionOf: enterprise name) equals: 2.
	self assert: (board positionOf: zathura name) equals: 2.
	self assert: (board lapOf: enterprise name) equals: 1.
	self assert: (board lapOf: zathura name) equals: 1
]

{ #category : #tests }
BoardTest >> testSpaceshipLandsOnWormHoleBoxSetsBackItselfFourBoxes [

	| enterprise board noEffect anEffect boxSequence box1 box2 box3 box4 box5 |
	enterprise := Spaceship called: 'Enterprise'.
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
		         and: 10
		         playedFor: 2
		         by: enterprise
		         with: boxSequence.
	board moveSpaceship: 3.
	board moveSpaceship: 2.

	self assert: (board positionOf: enterprise name) equals: 1.
	self assert: (board lapOf: enterprise name) equals: 1
]

{ #category : #tests }
BoardTest >> testSpaceshipRemainsInTheInitialPositionIfEffectIsApplied [

	| zathura delorean board noEffect anEffect boxSequence box1 box2 box3 box4 box5 |
	zathura := Spaceship called: 'Zathura'.
	delorean := Spaceship called: 'Delorean'.
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
		         and: 10
		         playedFor: 1
		         byMany: { 
				         zathura.
				         delorean }
		         with: boxSequence.
	board moveSpaceship: 2.

	self assert: (board positionOf: zathura name) equals: 2.
	self assert: (board positionOf: delorean name) equals: 0.
	self assert: (board lapOf: zathura name) equals: 1.
	self assert: (board lapOf: delorean name) equals: 1
]

{ #category : #tests }
BoardTest >> testSpaceshipThatLandsOnMoonWalkBoxCantMakeOthersGoToNegativePositions [

	| enterprise board noEffect anEffect boxSequence box1 box2 box3 box4 box5 delorean |
	enterprise := Spaceship called: 'Enterprise'.
	delorean := Spaceship called: 'Delorean'.
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
		         and: 10
		         playedFor: 2
		         byMany: { 
				         enterprise.
				         delorean }
		         with: boxSequence.
	board moveSpaceship: 5.
	board moveSpaceship: 1.

	self assert: (board positionOf: enterprise name) equals: 1.
	self assert: (board positionOf: delorean name) equals: 1.
	self assert: (board lapOf: enterprise name) equals: 1.
	self assert: (board lapOf: delorean name) equals: 1
]

{ #category : #tests }
BoardTest >> testSpaceshipThatLandsOnWormHoleBoxCantGoToNegativePositions [

	| delorean board noEffect anEffect boxSequence box1 box2 box3 box4 box5 |
	delorean := Spaceship called: 'Delorean'.
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
		         and: 10
		         playedFor: 2
		         by: delorean
		         with: boxSequence.
	board moveSpaceship: 1.

	self assert: (board positionOf: delorean name) equals: 1
]

{ #category : #tests }
BoardTest >> testSpaceshipsThatLandsOnAHyperJumpBoxEndUpFiveBoxesAfterThenFourBoxesAfter [

	| board noEffect anEffect boxSequence box1 box2 box3 box4 box5 delorean enterprise aParsecUnit |
	delorean := Spaceship called: 'Delorean'.
	enterprise := Spaceship called: 'Enterprise'.
	noEffect := NoEffect new.
	anEffect := HyperJumpEffect with: { 10. 8 }.
	aParsecUnit := ParsecUnit of: 20.

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
		         and: aParsecUnit
		         playedFor: 1
		         byMany: { 
				         delorean.
				         enterprise }
		         with: boxSequence.
	board moveSpaceship: 1.
	board moveSpaceship: 1.

	self assert: (board positionOf: delorean name) equals: 6.
	self assert: (board positionOf: enterprise name) equals: 5.

	board moveSpaceship: 1.
	board moveSpaceship: 1.
	self assert: (board positionOf: delorean name) equals: 7.
	self assert: (board positionOf: enterprise name) equals: 11
]

{ #category : #tests }
BoardTest >> testSpaceshipsThatLandsOnAHyperJumpBoxEndUpFiveBoxesAfterThenFourBoxesAfterWithFloatingLengths [

	| board noEffect anEffect boxSequence box1 box2 box3 box4 box5 enterprise zathura aParsecUnit |
	enterprise := Spaceship called: 'Enterprise'.
	zathura := Spaceship called: 'Zathura'.
	noEffect := NoEffect new.
	anEffect := HyperJumpEffect with: { 14. 13 }.
	aParsecUnit := ParsecUnit of: 100.

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
		         and: aParsecUnit
		         playedFor: 1
		         byMany: { 
				         enterprise.
				         zathura }
		         with: boxSequence.
	board moveSpaceship: 1.
	board moveSpaceship: 1.

	self assert: (board positionOf: enterprise name) equals: 3.
	self assert: (board positionOf: zathura name) equals: 2
]

{ #category : #tests }
BoardTest >> testSpeedUpDoesntTriggerAnotherSpeedUp [

	| zathura board anEffect speedUpBox box |
	zathura := Spaceship called: 'Zathura'.
	anEffect := NoEffect new.
	speedUpBox := SpeedUpEffect new.

	box := Box with: speedUpBox.

	board := Board
		         of: 10
		         and: 10
		         playedFor: 1
		         by: zathura
		         with: { box }.
	board move: zathura name by: 1.

	self assert: (board positionOf: zathura name) equals: 5
]

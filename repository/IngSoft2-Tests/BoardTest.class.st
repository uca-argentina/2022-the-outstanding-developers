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
	boxSequence := { 
		               aNormalBox.
		               aSpeedUpBox.
		               aWormHoleBox.
		               aMoonWalkBox.
		               aHyperJumpBox.
		               anAtomicBombBox }.
	board := Board
		         of: 15
		         and: (ParsecUnit of: 15)
		         playedFor: 1
		         with: boxSequence.
		
	self assert: board amountOfBoxes equals: 15.
	self assert: board amountOfNoEffectBoxes equals: 3.
	self assert: board amountOfSpeedUpBoxes equals: 3.
	self assert: board amountOfWormHoleBoxes equals: 3.
	self assert: board amountOfMoonWalkBoxes equals: 2.
	self assert: board amountOfHyperJumpBoxes equals: 2.
	self assert: board amountOfAtomicBombBoxes equals: 2
]

{ #category : #tests }
BoardTest >> testABoardOfOneHundredRandomGeneratedBoxesHasOneHundredBoxes [

	| n parsecs enterprise board distributions |
	n := 100.
	parsecs := ParsecUnit of: 100.
	enterprise := Spaceship called: 'enterprise'.
	
	distributions := OrderedCollection new.
	distributions add:
		(Distribution withProbabilityOf: 0.3 for: NoEffect).
	distributions add:
		(Distribution withProbabilityOf: 0.2 for: SpeedUpEffect).
	distributions add:
		(Distribution withProbabilityOf: 0.2 for: WormHoleEffect).
	distributions add:
		(Distribution withProbabilityOf: 0.1 for: (MoonWalkEffect for: n)).
	distributions add:
		(Distribution withProbabilityOf: 0.08 for: HyperJumpEffect).
	distributions add:
		(Distribution withProbabilityOf: 0.02 for: AtomicBombEffect).
	distributions add:
		(Distribution withProbabilityOf: 0.1 for: CardAwarderEffect).

	board := Board
		         of: n
		         and: parsecs
		         playedFor: 1
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
		         and: (ParsecUnit of: 10)
		         playedFor: 1
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

	| aBoxDistribution aBoard n parsecs aLoadedDie anOustandingGame aCardDistribution |
	n := 100.
	parsecs := ParsecUnit of: 100.
	aBoxDistribution := OrderedCollection new.
	aBoxDistribution add: (Distribution withProbabilityOf: 1 for: NoEffect).
	aLoadedDie := LoadedDie with: 1.
	aCardDistribution := OrderedCollection new.

	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: (SpeedCard behavingAsA: PermanentCard)).
	aBoard := Board
		          of: n
		          and: parsecs
		          playedFor: 1
		          givenBy: aBoxDistribution.
	anOustandingGame := OutstandingSpaceshipsGame
		                    playedByMany:
		                    { 'Enterprise'. 'Zathura'. 'Delorean' }
		                    on: aBoard
		                    throwing: aLoadedDie
		                    using: aCardDistribution.
	anOustandingGame play.
	anOustandingGame play.
	self
		should: [ aBoard move: 'Enterprise' by: 15 ]
		raise: Error
		withMessage: 'This is not the players turn'
]

{ #category : #tests }
BoardTest >> testASpaceshipThatLandsOnABoxWithNoEffectDoesntMove [

	| aBoard aBoxDistribution aLoadedDie aCardDistribution anOutstandingGame |
	aBoxDistribution := OrderedCollection new.
	aBoxDistribution add:
		(Distribution withProbabilityOf: 1 for: NoEffect).
	aLoadedDie := LoadedDie with: 3.

	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: (OverloadCard behavingAsA: PermanentCard)).

	aBoard := Board
		          of: 10
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          with: { (Box with: NoEffect new) }.
	
	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedBy: 'Enterprise'
		                     on: aBoard
		                     throwing: aLoadedDie
		                     using: aCardDistribution.
	anOutstandingGame play.
	
	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 3
]

{ #category : #tests }
BoardTest >> testASpaceshipThatLandsOnABoxWithSpeedUpEffectEndsUpFourBoxesAfter [

	| aBoard noEffect speedUpEffect boxSequence box1 box2 box3 box4 box5 aCardDistribution anOutstandingGame |
	noEffect := NoEffect new.
	speedUpEffect := SpeedUpEffect new.

	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: (OverloadCard behavingAsA: PermanentCard)).

	box1 := Box with: speedUpEffect.
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
	aBoard := Board
		          of: 10
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          with: boxSequence.

	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedBy: 'Enterprise'
		                     on: aBoard
		                     throwing: (LoadedDie with: 1)
		                     using: aCardDistribution.
	anOutstandingGame play.

	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 5
]

{ #category : #tests }
BoardTest >> testASpaceshipsLapPositionVariesToTwoAfterCompletingFirstLap [

	| aBoard aLoadedDie aCardDistribution anOtstandingGame |
	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: (OverloadCard behavingAsA: PermanentCard)).

	aBoard := Board
		          of: 10
		          and: (ParsecUnit of: 10)
		          playedFor: 2
		          with: { (Box with: NoEffect new) }.
	aLoadedDie := LoadedDie with: 5.
	anOtstandingGame := OutstandingSpaceshipsGame
		                    playedBy:'Enterprise'
		                    on: aBoard
		                    throwing: aLoadedDie
		                    using: aCardDistribution.
	anOtstandingGame play.
	anOtstandingGame play.
	anOtstandingGame play.

	self assert: (aBoard lapOf: 'Enterprise') equals: 2
]

{ #category : #tests }
BoardTest >> testASpaceshipsPositionVariesInFiveWithAFiniteBoardAfterOneRollOfALoadedDieWithFive [

	| board loadedDie aCardDistribution anOutstandingGame |
	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: (OverloadCard behavingAsA: PermanentCard)).

	board := Board
		         of: 10
		         and: (ParsecUnit of: 10)
		         playedFor: 1
		         with: { (Box with: NoEffect new) }.
	loadedDie := LoadedDie with: 5.
	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedBy: 'Enterprise'
		                     on: board
		                     throwing: loadedDie
		                     using: aCardDistribution.
	anOutstandingGame play.

	self assert: (board boxPositionOf: 'Enterprise') equals: 5
]

{ #category : #tests }
BoardTest >> testBoardCannotBeCreatedWithANumberOfBoxesMinorThanOne [

	| distributions |
	distributions := OrderedCollection new.
	distributions add: (Distribution withProbabilityOf: 1 for: NoEffect).

	self
		should: [ 
			Board
				of: -5
				and: (ParsecUnit of: 10)
				playedFor: 1
				givenBy: distributions ]
		raise: Error
		withMessage: 'Number of boxes should be greater than zero'
]

{ #category : #tests }
BoardTest >> testBoardCannotBeCreatedWithANumberOfLapsMinorThanOne [

	| distributions |

	distributions := OrderedCollection new.
	distributions add: (Distribution withProbabilityOf: 1 for: NoEffect).

	self
		should: [ 
			Board
				of: 15
				and: (ParsecUnit of: 10)
				playedFor: -1
				givenBy: distributions ]
		raise: Error
		withMessage: 'Number of laps should be greater than zero'
]

{ #category : #tests }
BoardTest >> testBoardCreatedWithTenBoxesAndALengthOfTwoHundredParsecsHasBoxesLengthOfTen [

	| distributions board aParsecUnit |
	distributions := OrderedCollection new.
	distributions add: (Distribution withProbabilityOf: 1 for: NoEffect).

	aParsecUnit := ParsecUnit of: 200.
	board := Board
		         of: 10
		         and: aParsecUnit
		         playedFor: 1
		         givenBy: distributions.

	self assert: board boxParsecLength equals: 20
]

{ #category : #tests }
BoardTest >> testBoardLengthCreatedInLigthYearsCanBeExpressedInParsecsOrLightYears [

	| distributions board aLightYearUnit |
	distributions := OrderedCollection new.
	distributions add: (Distribution withProbabilityOf: 1 for: NoEffect).
	aLightYearUnit := LightYearUnit of: 30.
	board := Board
		         of: 10
		         and: aLightYearUnit
		         playedFor: 1
		         givenBy: distributions.
	self assert: board boxParsecLength equals: 1.
	self assert: board boxLigthYearLength equals: 3
	
]

{ #category : #tests }
BoardTest >> testBoardLengthCreatedInParsecsCanBeExpressedInParsecsOrLightYears [

	| distributions board aParsecUnit |
	distributions := OrderedCollection new.
	distributions add: (Distribution withProbabilityOf: 1 for: NoEffect).
	aParsecUnit := ParsecUnit of: 200.
	board := Board
		         of: 10
		         and: aParsecUnit
		         playedFor: 1
		         givenBy: distributions.
	self assert: board boxParsecLength equals: 20.
	self assert: board boxLigthYearLength equals: 60
]

{ #category : #tests }
BoardTest >> testBoxesLengthIsAHalfWhenTheAmountOfParsecsIsHalfTheAmountOfBoxes [

	| distributions board aParsecUnit |
	distributions := OrderedCollection new.
	distributions add: (Distribution withProbabilityOf: 1 for: NoEffect).
	aParsecUnit := ParsecUnit of: 10.
	board := Board
		         of: 20
		         and: aParsecUnit
		         playedFor: 1
		         givenBy: distributions.

	self assert: board boxParsecLength equals: 0.5
]

{ #category : #tests }
BoardTest >> testPlayersInDifferentLapsReturnToTheFirstBoxOfItsLaps [

	| aBoard noEffect boxSequence box1 box2 box3 box4 box5 atomicBombEffect aCardDistribution anOutstandingGame |
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

	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: (OverloadCard behavingAsA: PermanentCard)).

	aBoard := Board
		          of: 5
		          and: (ParsecUnit of: 5)
		          playedFor: 3
		          with: boxSequence.

	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany:
		                     { 'Enterprise'. 'Zathura'. 'Delorean' }
		                     on: aBoard
		                     throwing:
		                     (LoadedDie withSequence:
			                      { 6. 6. 1. 6. 1. 1. 2. 1. 3 })
		                     using: aCardDistribution.

	anOutstandingGame play.
	anOutstandingGame play.
	anOutstandingGame play.

	anOutstandingGame play.
	anOutstandingGame play.
	anOutstandingGame play.

	anOutstandingGame play.
	anOutstandingGame play.

	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 3.
	self assert: (aBoard lapOf: 'Enterprise') equals: 3.

	self assert: (aBoard boxPositionOf: 'Zathura') equals: 3.
	self assert: (aBoard lapOf: 'Zathura') equals: 2.

	self assert: (aBoard boxPositionOf: 'Delorean') equals: 2.
	self assert: (aBoard lapOf: 'Delorean') equals: 1.

	anOutstandingGame play.

	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 1.
	self assert: (aBoard lapOf: 'Enterprise') equals: 3.

	self assert: (aBoard boxPositionOf: 'Zathura') equals: 1.
	self assert: (aBoard lapOf: 'Zathura') equals: 2.

	self assert: (aBoard boxPositionOf: 'Delorean') equals: 1.
	self assert: (aBoard lapOf: 'Delorean') equals: 1
]

{ #category : #tests }
BoardTest >> testSpaceshipLandsOnAtomicBombBoxSetsBackEveryoneToFirstBox [

	| board noEffect boxSequence box1 box2 box3 box4 box5 anEffect aCardDistribution anOutstandingGame |
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
		         and: (ParsecUnit of: 10)
		         playedFor: 1
		         with: boxSequence.
	
	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: (OverloadCard behavingAsA: PermanentCard)).
			
	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany:
		                     { 'Enterprise'. 'Zathura'. 'Delorean' }
		                     on: board
		                     throwing:
		                     (LoadedDie withSequence: { 3. 2. 1. 2 })
		                     using: aCardDistribution.
	anOutstandingGame play.
	anOutstandingGame play.
	anOutstandingGame play.
	anOutstandingGame play.

	self assert: (board boxPositionOf: 'Enterprise') equals: 1.
	self assert: (board boxPositionOf: 'Zathura') equals: 1.
	self assert: (board boxPositionOf: 'Delorean') equals: 1.

	self assert: (board lapOf: 'Enterprise') equals: 1.
	self assert: (board lapOf: 'Zathura') equals: 1.
	self assert: (board lapOf: 'Delorean') equals: 1
]

{ #category : #tests }
BoardTest >> testSpaceshipLandsOnMoonWalkBoxSetsBackOtherSpaceshipsExceptItself [

	| board noEffect anEffect boxSequence box1 box2 box3 box4 box5 aCardDistribution anOutstandingGame |

	noEffect := NoEffect new.
	anEffect := MoonWalkEffect displacing: 1.

	box1 := Box with: noEffect.
	box2 := Box with: anEffect.
	box3 := Box with: noEffect.
	box4 := Box with: noEffect.
	box5 := Box with: noEffect.

	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: (OverloadCard behavingAsA: PermanentCard)).

	boxSequence := { 
		               box1.
		               box2.
		               box3.
		               box4.
		               box5 }.
	board := Board
		         of: 10
		         and: (ParsecUnit of: 10)
		         playedFor: 1
		         with: boxSequence.

	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Enterprise'. 'Zathura' }
		                     on: board
		                     throwing: (LoadedDie withSequence: { 3. 2 })
		                     using: aCardDistribution.
	anOutstandingGame play.
	anOutstandingGame play.

	self assert: (board boxPositionOf: 'Enterprise') equals: 2.
	self assert: (board boxPositionOf: 'Zathura') equals: 2.
	self assert: (board lapOf: 'Enterprise') equals: 1.
	self assert: (board lapOf: 'Zathura') equals: 1
]

{ #category : #tests }
BoardTest >> testSpaceshipLandsOnWormHoleBoxSetsBackItselfFourBoxes [

	| board noEffect anEffect boxSequence box1 box2 box3 box4 box5 aCardDistribution anOutstandingGame |

	noEffect := NoEffect new.
	anEffect := WormHoleEffect new.

	box1 := Box with: noEffect.
	box2 := Box with: noEffect.
	box3 := Box with: noEffect.
	box4 := Box with: noEffect.
	box5 := Box with: anEffect.

	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: (OverloadCard behavingAsA: PermanentCard)).

	boxSequence := { 
		               box1.
		               box2.
		               box3.
		               box4.
		               box5 }.
	board := Board
		         of: 10
		         and: (ParsecUnit of: 10)
		         playedFor: 2
		         with: boxSequence.

	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedBy: 'Enterprise'
		                     on: board
		                     throwing: (LoadedDie withSequence: { 3. 2 })
		                     using: aCardDistribution.
	anOutstandingGame play.
	anOutstandingGame play.

	self assert: (board boxPositionOf: 'Enterprise') equals: 1.
	self assert: (board lapOf: 'Enterprise') equals: 1
]

{ #category : #tests }
BoardTest >> testSpaceshipRemainsInTheInitialPositionIfEffectIsApplied [

	| board noEffect anEffect boxSequence box1 box2 box3 box4 box5 aCardDistribution anOutstandingGame |
	noEffect := NoEffect new.
	anEffect := MoonWalkEffect displacing: 1.

	box1 := Box with: noEffect.
	box2 := Box with: anEffect.
	box3 := Box with: noEffect.
	box4 := Box with: noEffect.
	box5 := Box with: noEffect.

	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: (OverloadCard behavingAsA: PermanentCard)).

	boxSequence := { 
		               box1.
		               box2.
		               box3.
		               box4.
		               box5 }.
	board := Board
		         of: 10
		         and: (ParsecUnit of: 10)
		         playedFor: 1
		         with: boxSequence.
	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Enterprise'. 'Zathura' }
		                     on: board
		                     throwing: (LoadedDie with: 2)
		                     using: aCardDistribution.

	anOutstandingGame play.

	self assert: (board boxPositionOf: 'Enterprise') equals: 2.
	self assert: (board boxPositionOf: 'Zathura') equals: 0.

	self assert: (board lapOf: 'Enterprise') equals: 1.
	self assert: (board lapOf: 'Zathura') equals: 1
]

{ #category : #tests }
BoardTest >> testSpaceshipThatLandsOnMoonWalkBoxCantMakeOthersGoToNegativePositions [

	| board noEffect anEffect boxSequence box1 box2 box3 box4 box5 aCardDistribution anOutstandingGame |
	noEffect := NoEffect new.
	anEffect := MoonWalkEffect displacing: 10.

	box1 := Box with: anEffect.
	box2 := Box with: noEffect.
	box3 := Box with: noEffect.
	box4 := Box with: noEffect.
	box5 := Box with: noEffect.

	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: (OverloadCard behavingAsA: PermanentCard)).

	boxSequence := { 
		               box1.
		               box2.
		               box3.
		               box4.
		               box5 }.
	board := Board
		         of: 10
		         and: (ParsecUnit of: 10)
		         playedFor: 2
		         with: boxSequence.

	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Enterprise'. 'Delorean' }
		                     on: board
		                     throwing: (LoadedDie withSequence: { 5. 1 })
		                     using: aCardDistribution.
	anOutstandingGame play.
	anOutstandingGame play.

	self assert: (board boxPositionOf: 'Enterprise') equals: 1.
	self assert: (board boxPositionOf: 'Delorean') equals: 1.

	self assert: (board lapOf: 'Enterprise') equals: 1.
	self assert: (board lapOf: 'Delorean') equals: 1
]

{ #category : #tests }
BoardTest >> testSpaceshipThatLandsOnWormHoleBoxCantGoToNegativePositions [

	| board noEffect anEffect boxSequence box1 box2 box3 box4 box5 aCardDistribution anOutstandingGame |
	noEffect := NoEffect new.
	anEffect := WormHoleEffect new.

	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: (OverloadCard behavingAsA: PermanentCard)).

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
		         and: (ParsecUnit of: 10)
		         playedFor: 2
		         with: boxSequence.

	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedBy: 'Delorean'
		                     on: board
		                     throwing:
		                     (LoadedDie withSequence: { 1. 2. 3. 2 })
		                     using: aCardDistribution.
	anOutstandingGame play.

	self assert: (board boxPositionOf: 'Delorean') equals: 1
]

{ #category : #tests }
BoardTest >> testSpaceshipsOnABordInLightYearsThatLandsOnAHyperJumpBoxInParsecsEndsOnNextBox [

	| board noEffect anEffect boxSequence box1 box2 box3 aLigthYearUnit aCardDistribution anOutstandingGame |
	noEffect := NoEffect new.
	anEffect := HyperJumpEffect with: { (ParsecUnit of: 3) }.
	aLigthYearUnit := LightYearUnit of: 60.

	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: (OverloadCard behavingAsA: PermanentCard)).

	box1 := Box with: anEffect.
	box2 := Box with: noEffect.
	box3 := Box with: noEffect.

	boxSequence := { 
		               box1.
		               box2.
		               box3 }.
	board := Board
		         of: 10
		         and: aLigthYearUnit
		         playedFor: 1
		         with: boxSequence.

	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedBy: 'Delorean'
		                     on: board
		                     throwing: (LoadedDie with: 1)
		                     using: aCardDistribution.
	anOutstandingGame play.

	self assert: (board boxPositionOf: 'Delorean') equals: 2
]

{ #category : #tests }
BoardTest >> testSpaceshipsOnABordInParsecsThatLandsOnAHyperJumpBoxInLightYearsEndsOnNextBox [

	| board noEffect anEffect boxSequence box1 box2 box3 aParsecUnit aCardDistribution anOutstandingGame |
	noEffect := NoEffect new.
	anEffect := HyperJumpEffect with: { (LightYearUnit of: 15) }.
	aParsecUnit := ParsecUnit of: 40.

	box1 := Box with: anEffect.
	box2 := Box with: noEffect.
	box3 := Box with: noEffect.

	boxSequence := { 
		               box1.
		               box2.
		               box3 }.
	board := Board
		         of: 10
		         and: aParsecUnit
		         playedFor: 1
		         with: boxSequence.
	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: (OverloadCard behavingAsA: PermanentCard)).

	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedBy: 'Delorean'
		                     on: board
		                     throwing: (LoadedDie with: 1)
		                     using: aCardDistribution.

	anOutstandingGame play.

	self assert: (board boxPositionOf: 'Delorean') equals: 2
]

{ #category : #tests }
BoardTest >> testSpaceshipsThatLandsOnAHyperJumpBoxEndUpFiveBoxesAfterThenFourBoxesAfter [

	| board noEffect anEffect boxSequence box1 box2 box3 box4 box5 aParsecUnit aCardDistribution anOutstandingGame |
	noEffect := NoEffect new.
	anEffect := HyperJumpEffect with: { 
			            (ParsecUnit of: 10).
			            (ParsecUnit of: 8) }.
	aParsecUnit := ParsecUnit of: 20.

	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: (OverloadCard behavingAsA: PermanentCard)).

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
		         with: boxSequence.

	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Delorean'. 'Enterprise' }
		                     on: board
		                     throwing: (LoadedDie with: 1)
		                     using: aCardDistribution.
	anOutstandingGame play.
	anOutstandingGame play.

	self assert: (board boxPositionOf: 'Delorean') equals: 6.
	self assert: (board boxPositionOf: 'Enterprise') equals: 5.

	anOutstandingGame play.
	anOutstandingGame play.
	
	self assert: (board boxPositionOf: 'Delorean') equals: 7.
	self assert: (board boxPositionOf: 'Enterprise') equals: 11
]

{ #category : #tests }
BoardTest >> testSpaceshipsThatLandsOnAHyperJumpBoxEndUpFiveBoxesAfterThenFourBoxesAfterWithFloatingLengths [

	| board noEffect anEffect boxSequence box1 box2 box3 box4 box5 aParsecUnit aCardDistribution anOutstandingGame |
	noEffect := NoEffect new.
	anEffect := HyperJumpEffect with: { ParsecUnit of: 14. ParsecUnit of: 13 }.
	aParsecUnit := ParsecUnit of: 100.

	box1 := Box with: anEffect.
	box2 := Box with: noEffect.
	box3 := Box with: noEffect.
	box4 := Box with: noEffect.
	box5 := Box with: noEffect.
	
	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: (OverloadCard behavingAsA: PermanentCard)).

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
		         with: boxSequence.
		
	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany:
		                     { 'Enterprise'. 'Zathura'}
		                     on: board
		                     throwing:
		                     (LoadedDie with: 1)
		                     using: aCardDistribution.
	anOutstandingGame play.
	anOutstandingGame play.

	self assert: (board boxPositionOf: 'Enterprise') equals: 3.
	self assert: (board boxPositionOf: 'Zathura') equals: 2
]

{ #category : #tests }
BoardTest >> testSpaceshipsThatLandsOnAHyperJumpBoxWithLightYearsEndsOnNextBox [

	| board noEffect anEffect boxSequence box1 box2 box3 aLightYearUnit aCardDistribution anOutstandingGame |
	noEffect := NoEffect new.
	anEffect := HyperJumpEffect with: { (LightYearUnit of: 6) }.
	aLightYearUnit := LightYearUnit of: 40.

	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: (OverloadCard behavingAsA: PermanentCard)).

	box1 := Box with: anEffect.
	box2 := Box with: noEffect.
	box3 := Box with: noEffect.

	boxSequence := { 
		               box1.
		               box2.
		               box3 }.
	board := Board
		         of: 10
		         and: aLightYearUnit
		         playedFor: 1
		         with: boxSequence.

	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedBy: 'Delorean'
		                     on: board
		                     throwing: (LoadedDie with: 1)
		                     using: aCardDistribution.
	anOutstandingGame play.

	self assert: (board boxPositionOf: 'Delorean') equals: 2
]

{ #category : #tests }
BoardTest >> testSpeedUpDoesntTriggerAnotherSpeedUp [

	| board anEffect speedUpBox box aCardDistribution anOutstandingGame |
	anEffect := NoEffect new.
	speedUpBox := SpeedUpEffect new.

	aCardDistribution := OrderedCollection new.
	aCardDistribution add: (Distribution
			 withProbabilityOf: 1
			 for: (OverloadCard behavingAsA: PermanentCard)).

	box := Box with: speedUpBox.

	board := Board
		         of: 10
		         and: (ParsecUnit of: 10)
		         playedFor: 1
		         with: { box }.
	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedBy: 'Zathura'
		                     on: board
		                     throwing: (LoadedDie with: 1)
		                     using: aCardDistribution.
	anOutstandingGame play.

	self assert: (board boxPositionOf: 'Zathura') equals: 5
]

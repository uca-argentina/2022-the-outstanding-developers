Class {
	#name : #SpaceshipTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
SpaceshipTest >> should: block raise: expectedErrorClass withMessage: expectedErrorMessage [

	self
		should: block
		raise: expectedErrorClass
		whoseDescriptionIncludes: expectedErrorMessage
		description: 'Test did not fail as expected'
]

{ #category : #tests }
SpaceshipTest >> testDiceCupCanBeAddedToSpaceshipPreviousDiceCup [
	
	| spaceship loadedDie1 loadedDie2 diceCup loadedDie3 loadedDie4 anotherDiceCup aDiceCup |
	loadedDie1 := LoadedDie with: 5.
	loadedDie2 := LoadedDie with: 7.
	loadedDie3 := LoadedDie with: 3.
	loadedDie4 := LoadedDie with: 8.
	aDiceCup := DiceCup withAll: { loadedDie1. loadedDie2 }.
	anotherDiceCup := DiceCup withAll: { loadedDie3. loadedDie4 }.
	diceCup := DiceCup withAll: { aDiceCup. anotherDiceCup }.
	spaceship := Spaceship assignedTo: 'aPlayer' with: aDiceCup.
	spaceship addDie: anotherDiceCup.
	self assert: spaceship play identicalTo: diceCup roll.
]

{ #category : #tests }
SpaceshipTest >> testDieCanBeAddedToSpaceshipPreviousDice [
	
	| spaceship loadedDie1 loadedDie2 diceCup |
	loadedDie1 := LoadedDie with: 5.
	loadedDie2 := LoadedDie with: 7.
	spaceship := Spaceship assignedTo: 'aPlayer' with: loadedDie1.
	diceCup := DiceCup withAll: { loadedDie1. loadedDie2 }.
	spaceship addDie: loadedDie2.
	self assert: spaceship play identicalTo: diceCup roll.
]

{ #category : #tests }
SpaceshipTest >> testSpaceshipCannotBeCreatedWithEmptyPlayer [
	| aDice |
	aDice := RandomDie with: 6.
	self
		should: [ Spaceship assignedTo: '' with: aDice]
		raise: Error
		withMessage: 'Spaceship has to be assigned to a valid player'
]

{ #category : #tests }
SpaceshipTest >> testSpaceshipCreatedWithPlayerNameIsValid [

	| spaceship playerName aDice |
	playerName := 'SomePlayer'.
	aDice := RandomDie with: 6.
	spaceship := Spaceship assignedTo: playerName with: aDice.
	self assert: spaceship player identicalTo: playerName
]

{ #category : #tests }
SpaceshipTest >> testSpaceshipIsCreatedWithInitialPositionInZero [

	| aSpaceship |
	aSpaceship := Spaceship assignedTo: 'aPlayerName'.
	self assert: aSpaceship position equals: 0.
]

{ #category : #tests }
SpaceshipTest >> testSpaceshipPlayIsResultOfLoadedDieRoll [
	
	| spaceship loadedDie |
	loadedDie := LoadedDie with: 5.
	spaceship := Spaceship assignedTo: 'aPlayer' with: loadedDie.
	self assert: spaceship play identicalTo: loadedDie roll.
]

{ #category : #tests }
SpaceshipTest >> testSpaceshipVariesItsPositionTheNumberOfBoxesOfTheLoadedDieRollResult [

	| aSpaceship aLoadedDie positionsToMove|
	aSpaceship := Spaceship assignedTo: 'aPlayerName'.
	aLoadedDie := LoadedDie with: 5.
	positionsToMove:= aLoadedDie roll.
	aSpaceship move: positionsToMove.
	
	self assert: aSpaceship position equals: positionsToMove.
]

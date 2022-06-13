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
SpaceshipTest >> testHashOfSpaceshipOfPlayerOneIsEqualToHashOfSpaceshipOfPlayerOne [

	| spaceshipOne spaceshipTwo |
	spaceshipOne := Spaceship called: 'playerOne'.
	spaceshipTwo := Spaceship called: 'playerOne'.
	self assert: spaceshipOne hash equals: spaceshipTwo hash
]

{ #category : #tests }
SpaceshipTest >> testSpaceshipCannotBeCreatedWithEmptyPlayer [

	self
		should: [ Spaceship called: '' ]
		raise: Error
		withMessage: 'Spaceship has to be assigned to a valid player'
]

{ #category : #tests }
SpaceshipTest >> testSpaceshipCreatedWithPlayerNameIsValid [

	| spaceship playerName |
	playerName := 'SomePlayer'.
	spaceship := Spaceship called: playerName.
	self assert: spaceship name identicalTo: playerName
]

{ #category : #tests }
SpaceshipTest >> testSpaceshipHasOnePendingCardToPlay [

	| delorean aCard |
	delorean := Spaceship called: 'Delorean'.
	aCard := OverloadCard new.
	delorean receives: aCard.

	self assert: delorean cardDeck equals: { aCard }
]

{ #category : #tests }
SpaceshipTest >> testSpaceshipHasTwoPendingCardsToPlay [

	| delorean overloadCard speedCard cards |
	delorean := Spaceship called: 'Delorean'.
	overloadCard := OverloadCard new.
	speedCard := SpeedCard new.
	cards := { 
		         overloadCard.
		         speedCard }.
	delorean receivesMany: cards.

	self assert: delorean cardDeck equals: cards
]

{ #category : #tests }
SpaceshipTest >> testSpaceshipOfPlayerOneIsDifferentFromSpaceshipOfPlayerTwo [

	| spaceshipOne spaceshipTwo |
	spaceshipOne := Spaceship called: 'playerOne'.
	spaceshipTwo := Spaceship called: 'playerTwo'.
	self assert: spaceshipOne ~= spaceshipTwo
]

{ #category : #tests }
SpaceshipTest >> testSpaceshipOfPlayerOneIsEqualToSpaceshipOfPlayerOne [

	| spaceshipOne spaceshipTwo |
	spaceshipOne := Spaceship called: 'playerOne'.
	spaceshipTwo := Spaceship called: 'playerOne'.
	self assert: spaceshipOne equals: spaceshipTwo
]

{ #category : #tests }
SpaceshipTest >> testSpaceshipsHashOfPlayerOneIsDifferentFromSpaceshipsHashOfPlayerTwo [

	| spaceshipOne spaceshipTwo |
	spaceshipOne := Spaceship called: 'playerOne'.
	spaceshipTwo := Spaceship called: 'playerTwo'.
	self assert: spaceshipOne hash ~= spaceshipTwo hash
]

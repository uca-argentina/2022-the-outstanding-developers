Class {
	#name : #OutstandingSpaceshipsGame,
	#superclass : #Object,
	#instVars : [
		'board',
		'dice',
		'stateOfGame',
		'spaceshipsCardDeck',
		'spaceshipsPlaying',
		'spaceshipsAffectingCardDeck'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #assertion }
OutstandingSpaceshipsGame class >> assertValidNumberOfSpaceshipsIsGreaterThanZero: spaceships [

	spaceships isEmpty ifTrue: [ 
		Error signal: 'Must use at least one spaceship' ]
]

{ #category : #assertion }
OutstandingSpaceshipsGame class >> assertValidSpaceships: spaceships [

	self assertValidNumberOfSpaceshipsIsGreaterThanZero: spaceships.
	self assertValidSpaceshipsAsigneesAreNotRepeated: spaceships
]

{ #category : #assertion }
OutstandingSpaceshipsGame class >> assertValidSpaceshipsAsigneesAreNotRepeated: spaceships [

	| uniqueSpaceships |
	uniqueSpaceships := spaceships asOrderedCollection removeDuplicates asArray.
	spaceships size = uniqueSpaceships size ifFalse: [ 
		Error signal: 'Spaceships must be assigned to different players' ]
]

{ #category : #'instance creation' }
OutstandingSpaceshipsGame class >> playedBy: spaceship on: aBoard throwing: dice using: aCardDistribution [

	^ self
		  playedByMany: { spaceship } on: aBoard throwing: dice using: aCardDistribution
]

{ #category : #'instance creation' }
OutstandingSpaceshipsGame class >> playedByMany: spaceships on: aBoard throwing: dice [

	self assertValidSpaceships: spaceships.
	^ self new initializeWith: aBoard many: spaceships and: dice
]

{ #category : #'instance creation' }
OutstandingSpaceshipsGame class >> playedByMany: spaceships on: aBoard throwing: dice using: aCardDistribution [

	self assertValidSpaceships: spaceships.
	^ self new
		  initializeWith: aBoard
		  many: spaceships
		  throwing: dice
		  using: aCardDistribution
]

{ #category : #'instance creation' }
OutstandingSpaceshipsGame class >> playedOn: aBoard throwing: dice [

	^ self new initializeWith: aBoard and: dice
]

{ #category : #asserting }
OutstandingSpaceshipsGame >> assertCardCanBeThrown [
	self shouldBeImplemented.
]

{ #category : #assertion }
OutstandingSpaceshipsGame >> assertCardCanBeThrown: aClass [ 
	self shouldBeImplemented.
]

{ #category : #assertion }
OutstandingSpaceshipsGame >> assertCardCanBeThrown: aCard from: aSpaceship [
	
	board assertACardCanBeThrown.
	aCard assertItIsThrowableIfCurrentTurnBelongingToSpaceshipIs:
		(board isSpaceshipsTurn: aSpaceship)
]

{ #category : #accessing }
OutstandingSpaceshipsGame >> cardsAffectingOf: aSpaceship [ 

	^ (spaceshipsAffectingCardDeck select: [ :spaceshipCardDeck | 
		   spaceshipCardDeck spaceship = aSpaceship ])
]

{ #category : #setup }
OutstandingSpaceshipsGame >> dealCards [

	
]

{ #category : #setup }
OutstandingSpaceshipsGame >> dealWith: aCardDistribution [

	| cardGenerator |
	cardGenerator := RandomEventGenerator
		                 with: 1
		                 using: aCardDistribution.
	spaceshipsCardDeck := OrderedCollection new.
	spaceshipsPlaying do: [ :spaceship | 
		2 timesRepeat: [ 
			spaceshipsCardDeck add:
				(SpaceshipCardHolder of: spaceship holding: (cardGenerator generate at: 1)) ] ]
]

{ #category : #accessing }
OutstandingSpaceshipsGame >> deckOf: aSpaceship [

	^ (spaceshipsCardDeck select: [ :spaceshipCardDeck | 
		   spaceshipCardDeck spaceship = aSpaceship ])
]

{ #category : #initialization }
OutstandingSpaceshipsGame >> initializeWith: aBoard and: someDice [

	board := aBoard.
	dice := someDice.
	stateOfGame := GameNotWonState new
]

{ #category : #initialization }
OutstandingSpaceshipsGame >> initializeWith: aBoard many: spaceships and: someDice [

	board := aBoard.
	aBoard playingWith: spaceships.
	spaceshipsPlaying := spaceships.
	dice := someDice.
	stateOfGame := GameNotWonState new.
	self dealCards.
]

{ #category : #initialization }
OutstandingSpaceshipsGame >> initializeWith: aBoard many: spaceships throwing: someDice using: aCardDistribution [

	board := aBoard.
	aBoard playingWith: spaceships.
	spaceshipsPlaying := spaceships.
	dice := someDice.
	stateOfGame := GameNotWonState new.
	spaceshipsAffectingCardDeck := OrderedCollection new.
	self dealWith: aCardDistribution.
]

{ #category : #playing }
OutstandingSpaceshipsGame >> play [

	stateOfGame play: self
]

{ #category : #playing }
OutstandingSpaceshipsGame >> playTurn [

	| resultOfTheRoll deckOfSpaceship effectOnDiceThrow |
	resultOfTheRoll := dice roll.
	deckOfSpaceship := self cardsAffectingOf: board spaceshipPlaying.
	effectOnDiceThrow := deckOfSpaceship sum: [ :cardHolder | cardHolder effectOnThrow ].
	board moveSpaceship: resultOfTheRoll + effectOnDiceThrow.
	board thereIsAWinner ifTrue: [ stateOfGame := GameWonState new ]
]

{ #category : #playing }
OutstandingSpaceshipsGame >> startSimulation [

	[ self thereIsAWinner ] whileFalse: [ self playTurn ]
]

{ #category : #results }
OutstandingSpaceshipsGame >> thereIsAWinner [

	^ stateOfGame isFinished
]

{ #category : #'card throwing' }
OutstandingSpaceshipsGame >> throws: aCard from: aSpaceship [ 
	
	"Self assert de que existe la carta en su deck"
	"self assertCardCanBeThrown: aCard in: board."
	
	| cardToBeRemoved |
	self assertCardCanBeThrown: aCard from: aSpaceship.
	cardToBeRemoved := spaceshipsCardDeck findFirst: [ :spaceshipCardDeck | 
		                 spaceshipCardDeck spaceship = aSpaceship and: (spaceshipCardDeck card) = aCard ].
	spaceshipsCardDeck removeAt: cardToBeRemoved.
	
]

{ #category : #results }
OutstandingSpaceshipsGame >> winner [

	^ board winner
]

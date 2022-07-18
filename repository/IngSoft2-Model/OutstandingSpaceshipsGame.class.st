Class {
	#name : #OutstandingSpaceshipsGame,
	#superclass : #Object,
	#instVars : [
		'board',
		'dice',
		'stateOfGame',
		'spaceshipsCardDeck',
		'spaceshipsPlaying',
		'spaceshipsAffectingCardDeck',
		'lastPlayedCard',
		'usedCardsDeck',
		'deck',
		'cardsAffectingCards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #assertion }
OutstandingSpaceshipsGame class >> assertNumberOfSpaceshipsIsGreaterThanZeroFor: spaceships [

	spaceships isEmpty ifTrue: [ 
		Error signal: 'Must use at least one spaceship' ]
]

{ #category : #assertion }
OutstandingSpaceshipsGame class >> assertSpaceshipsAreValid: spaceships [

	self assertNumberOfSpaceshipsIsGreaterThanZeroFor: spaceships.
	self assertValidSpaceshipsAreNotRepeated: spaceships
]

{ #category : #assertion }
OutstandingSpaceshipsGame class >> assertValidSpaceshipsAreNotRepeated: spaceships [

	| uniqueSpaceships |
	uniqueSpaceships := spaceships asOrderedCollection removeDuplicates
		                    asArray.
	spaceships size = uniqueSpaceships size ifFalse: [ 
		Error signal: 'Spaceships must be assigned to different players' ]
]

{ #category : #'instance creation' }
OutstandingSpaceshipsGame class >> playedBy: spaceship on: aBoard throwing: dice using: aCardDistribution [

	^ self
		  playedByMany: { spaceship }
		  on: aBoard
		  throwing: dice
		  using: aCardDistribution
]

{ #category : #'instance creation' }
OutstandingSpaceshipsGame class >> playedByMany: spaceships on: aBoard throwing: dice using: aFiniteDeck [

	self assertSpaceshipsAreValid: spaceships.
	^ self new
		  initializeWith: aBoard
		  many: spaceships
		  throwing: dice
		  using: aFiniteDeck
]

{ #category : #playing }
OutstandingSpaceshipsGame >> add: aCard affecting: aTargetCard [

	cardsAffectingCards add:
		(CardAffectation from: aCard to: (SpaceshipHoldingACard
				  of: aTargetCard spaceship
				  holding: aTargetCard create)).
	lastPlayedCard := aCard.
]

{ #category : #playing }
OutstandingSpaceshipsGame >> add: aCard affectingAll: targetCards [

	spaceshipsPlaying do: [ :spaceship | 
		cardsAffectingCards add: (CardAffectation
				 from: aCard
				 to:
				 (SpaceshipHoldingACard of: spaceship holding: targetCards create)) ].
	lastPlayedCard := aCard
]

{ #category : #playing }
OutstandingSpaceshipsGame >> addAffecting: aSpaceshipHoldingACard [
	
	lastPlayedCard := aSpaceshipHoldingACard card.
	spaceshipsAffectingCardDeck add: aSpaceshipHoldingACard
]

{ #category : #playing }
OutstandingSpaceshipsGame >> addAffectingAll: aCard [ 
	
	lastPlayedCard := aCard.
	spaceshipsPlaying do: [ :spaceship | self addAffecting: (SpaceshipHoldingACard of: spaceship holding: aCard) ]
]

{ #category : #playing }
OutstandingSpaceshipsGame >> addToHolders: aSpaceshipHoldingACard [

	spaceshipsCardDeck add: aSpaceshipHoldingACard
]

{ #category : #playing }
OutstandingSpaceshipsGame >> addToUsedCards: aCard [ 
	usedCardsDeck add: aCard 
]

{ #category : #accessing }
OutstandingSpaceshipsGame >> amountOfCards [

	^ deck cardAmount
]

{ #category : #accessing }
OutstandingSpaceshipsGame >> amountOfUsedCards [

	^ usedCardsDeck size
]

{ #category : #asserting }
OutstandingSpaceshipsGame >> assert: aCard canBeThrownBy: aSpaceship [

	board assertACardCanBeThrown.
	aCard
		assertItIsThrowableInTurn: (board isTheTurnOf: aSpaceship)
		in: self
]

{ #category : #asserting }
OutstandingSpaceshipsGame >> assertCardBelongsToSpaceshipIn: aCardIndex [

	aCardIndex = 0 ifTrue: [ 
		Error signal: 'The spaceship doesnt have cards to throw' ]
]

{ #category : #asserting }
OutstandingSpaceshipsGame >> assertCardCanAffect: aTargetCard [

	| cardToAffect |
	cardToAffect := spaceshipsAffectingCardDeck findFirst: [ 
		                :spaceshipAffectingCardDeck | 
		                spaceshipAffectingCardDeck card = aTargetCard and: [ 
			                aTargetCard isAppliedTo:
				                spaceshipAffectingCardDeck spaceship ] ].
	cardToAffect = 0 ifTrue: [ 
		Error signal:
			'SpeedBoost card cant be used if the chosen card is not in game' ]
]

{ #category : #asserting }
OutstandingSpaceshipsGame >> assertCardCanBeRemovedAt: aCardIndex [

	aCardIndex = 0 ifTrue: [ 
		Error signal:
			'Cancellation card cant be used if the chosen card is not in game' ]
]

{ #category : #calculations }
OutstandingSpaceshipsGame >> calculateEffectOnDiceThrowFor: aDeckOfCardsHavingEffectOnSpaceship [

	| effectOnDiceThrow usedEffectsOnCards |
	effectOnDiceThrow := 0.
	usedEffectsOnCards := OrderedCollection new.
	aDeckOfCardsHavingEffectOnSpaceship isEmpty ifTrue: [ ^ 0 ].
	aDeckOfCardsHavingEffectOnSpaceship do: [ :cardHolder | 
		effectOnDiceThrow := effectOnDiceThrow + (cardHolder
			                      effectOnThrowWith: cardsAffectingCards
			                      and: usedEffectsOnCards) ].
	^ effectOnDiceThrow
]

{ #category : #playing }
OutstandingSpaceshipsGame >> cancel: aCard affecting: aSpaceship [

	| cardToBeRemoved |
	cardToBeRemoved := spaceshipsAffectingCardDeck findFirst: [ 
		                   :spaceshipAffectingCardDeck | 
		                   spaceshipAffectingCardDeck spaceship = aSpaceship 
			                   and: [ 
			                   spaceshipAffectingCardDeck card name
			                   = aCard name ] ].
	self assertCardCanBeRemovedAt: cardToBeRemoved.
	self removeFromCardAfecting: aCard and: aSpaceship.
	lastPlayedCard := CancellationCard create.
	spaceshipsAffectingCardDeck removeAt: cardToBeRemoved.
	usedCardsDeck add: aCard
]

{ #category : #playing }
OutstandingSpaceshipsGame >> cancelAllFrom: aCardType [

	spaceshipsPlaying do: [ :spaceship | 
		self cancel: aCardType affecting: spaceship ].
	lastPlayedCard := CancellationCard create
]

{ #category : #asserting }
OutstandingSpaceshipsGame >> cardCanBeDealt [

	^ self amountOfUsedCards ~= 0 or: [ self amountOfCards ~= 0 ]
]

{ #category : #calculations }
OutstandingSpaceshipsGame >> countActivePermanentCards [

	^ spaceshipsAffectingCardDeck count: [ :spaceshipAffectingCardDeck | 
		  spaceshipAffectingCardDeck card typeOfCard = 'Permanent' ]
]

{ #category : #setup }
OutstandingSpaceshipsGame >> deal [

	spaceshipsCardDeck := OrderedCollection new.
	spaceshipsPlaying do: [ :spaceship | 
		2 timesRepeat: [ 
			self cardCanBeDealt ifTrue: [ 
				spaceshipsCardDeck add:
					(SpaceshipHoldingACard of: spaceship holding: deck dealCard) ] ] ]
]

{ #category : #playing }
OutstandingSpaceshipsGame >> dealCard [

	^ deck dealCard
]

{ #category : #accessing }
OutstandingSpaceshipsGame >> deckOf: aSpaceship [

	^ spaceshipsCardDeck select: [ :spaceshipCardDeck | 
		  spaceshipCardDeck spaceship = aSpaceship ]
]

{ #category : #accessing }
OutstandingSpaceshipsGame >> deckOfCardAffecting: aSpaceship [

	^ spaceshipsAffectingCardDeck select: [ :spaceshipCardDeck | 
		  spaceshipCardDeck spaceship = aSpaceship ]
]

{ #category : #initialization }
OutstandingSpaceshipsGame >> initializeWith: aBoard many: spaceships throwing: someDice using: aFiniteDeck [

	lastPlayedCard := NullCard.
	board := aBoard.
	aBoard playingWith: spaceships in: self.
	spaceshipsPlaying := spaceships.
	dice := someDice.
	stateOfGame := GameNotWonState new.
	spaceshipsAffectingCardDeck := OrderedCollection new.
	cardsAffectingCards := OrderedCollection new.
	usedCardsDeck := OrderedCollection new.
	deck := aFiniteDeck.
	self deal
]

{ #category : #accessing }
OutstandingSpaceshipsGame >> lastPlayedCard [

	^ lastPlayedCard
]

{ #category : #playing }
OutstandingSpaceshipsGame >> play [

	stateOfGame play: self
]

{ #category : #playing }
OutstandingSpaceshipsGame >> playTurn [

	| resultOfTheRoll deckOfSpaceship effectOnDiceThrow |
	resultOfTheRoll := dice roll.
	deckOfSpaceship := self deckOfCardAffecting: board spaceshipPlaying.
	effectOnDiceThrow := self calculateEffectOnDiceThrowFor:
		                     deckOfSpaceship.
	board moveSpaceship: resultOfTheRoll + effectOnDiceThrow.
	self refillDeckIfEmpty.
	board thereIsAWinner ifTrue: [ stateOfGame := GameWonState new ]
]

{ #category : #playing }
OutstandingSpaceshipsGame >> refillDeckIfEmpty [

	deck cardAmount = 0 ifTrue: [ 
		deck reSetWith: usedCardsDeck shuffle.
		usedCardsDeck := OrderedCollection new ]
]

{ #category : #playing }
OutstandingSpaceshipsGame >> removeFromCardAfecting: aCard and: aSpaceship [

	cardsAffectingCards removeAllSuchThat: [ :cardAffecting | 
		cardAffecting targetCard name = aCard name and: [ 
			cardAffecting targetSpaceship = aSpaceship ] ]
]

{ #category : #playing }
OutstandingSpaceshipsGame >> repeatEffectOn: aSpaceship [

	board lastBox effect reApplyEffectTo: aSpaceship on: board.
	lastPlayedCard := RepeatCard create
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

	| cardToBeRemoved |
	cardToBeRemoved := spaceshipsCardDeck findFirst: [ :spaceshipCardDeck | 
		                   spaceshipCardDeck spaceship = aSpaceship and: [ 
			                   spaceshipCardDeck card = aCard ] ].
	self assertCardBelongsToSpaceshipIn: cardToBeRemoved.
	self
		assert: (spaceshipsCardDeck at: cardToBeRemoved) card
		canBeThrownBy: aSpaceship.
	spaceshipsCardDeck removeAt: cardToBeRemoved.
	aCard incorporateTo: self
]

{ #category : #results }
OutstandingSpaceshipsGame >> winner [

	^ board winner
]

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

	self assertValidSpaceships: spaceships.
	^ self new
		  initializeWith: aBoard
		  many: spaceships
		  throwing: dice
		  using: aFiniteDeck
]

{ #category : #playing }
OutstandingSpaceshipsGame >> addAffecting: aSpaceshipCardHolder [
	
	lastPlayedCard := aSpaceshipCardHolder card.
	spaceshipsAffectingCardDeck add: aSpaceshipCardHolder
]

{ #category : #playing }
OutstandingSpaceshipsGame >> addAffectingAll: aCard [ 
	
	lastPlayedCard := aCard.
	spaceshipsPlaying do: [ :spaceship | self addAffecting: (SpaceshipCardHolder of: spaceship holding: aCard) ]
]

{ #category : #playing }
OutstandingSpaceshipsGame >> addCardAffectingAll: aCard for: aTargetCard [

	spaceshipsPlaying do: [ :spaceship | 
		cardsAffectingCards add:
			(CardAffencting from: aCard to: (SpaceshipCardHolder
				  of: spaceship
				  holding: aTargetCard create)) ].
	lastPlayedCard := aCard.
]

{ #category : #playing }
OutstandingSpaceshipsGame >> addCardAffectingCard: aCard on: aTargetCard [

	cardsAffectingCards add:
		(CardAffencting from: aCard to: (SpaceshipCardHolder
				  of: aTargetCard spaceship
				  holding: aTargetCard create)).
	lastPlayedCard := aCard.
]

{ #category : #playing }
OutstandingSpaceshipsGame >> addHolding: aSpaceshipCardHolder [

	spaceshipsCardDeck add: aSpaceshipCardHolder
]

{ #category : #playing }
OutstandingSpaceshipsGame >> addUsedcard: aCard [ 
	usedCardsDeck add: aCard 
]

{ #category : #accessing }
OutstandingSpaceshipsGame >> amountOfCards [
	^ deck cardAmount  
]

{ #category : #properties }
OutstandingSpaceshipsGame >> amountOfUsedCards [

	^ usedCardsDeck size
]

{ #category : #assertion }
OutstandingSpaceshipsGame >> assertCardBelongsToSpaceship: cardPosition [

	cardPosition = 0 ifTrue: [ 
		Error signal: 'The spaceship doesnt have cards to throw' ]
]

{ #category : #asserting }
OutstandingSpaceshipsGame >> assertCardCanAffect: aTargetCard [

	| cardToAffect |
	cardToAffect := spaceshipsAffectingCardDeck findFirst: [ :spaceshipAffectingCardDeck | 
		spaceshipAffectingCardDeck card = aTargetCard and: [ 
			aTargetCard isAppliedTo: spaceshipAffectingCardDeck spaceship ] ].
	cardToAffect = 0 ifTrue: [ Error signal: 'SpeedBoost card cant be used if the chosen card is not in game' ]
]

{ #category : #assertion }
OutstandingSpaceshipsGame >> assertCardCanBeRemoved: aCardPosition [

	aCardPosition = 0 ifTrue: [ 
		Error signal:
			'Cancellation card cant be used if the chosen card is not in game' ]
]

{ #category : #assertion }
OutstandingSpaceshipsGame >> assertCardCanBeThrown: aCard from: aSpaceship [

	board assertACardCanBeThrown.
	aCard
		assertItIsThrowableInTurn: (board isSpaceshipsTurn: aSpaceship)
		in: self
]

{ #category : #calculations }
OutstandingSpaceshipsGame >> calculateEffectOnDiceThrow [
	self shouldBeImplemented.
]

{ #category : #calculations }
OutstandingSpaceshipsGame >> calculateEffectOnDiceThrowFor: aDeck [

	| effectOnDiceThrow usedEffectsOnCards |
	effectOnDiceThrow := 0.
	usedEffectsOnCards := OrderedCollection new.
	aDeck isEmpty ifTrue: [ ^ 0 ].
	aDeck do: [ :cardHolder | 
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
			                   spaceshipAffectingCardDeck card name = aCard name ] ].
	self assertCardCanBeRemoved: cardToBeRemoved.
	self removeFromCardAfecting: aCard and: aSpaceship.
	lastPlayedCard := CancellationCard create.
	spaceshipsAffectingCardDeck removeAt: cardToBeRemoved.
	usedCardsDeck add: aCard.
]

{ #category : #playing }
OutstandingSpaceshipsGame >> cancelAll: cardType [
	spaceshipsPlaying do: [ :spaceship | 
		self cancel: cardType affecting: spaceship ].
	lastPlayedCard := CancellationCard create.
]

{ #category : #validation }
OutstandingSpaceshipsGame >> cardCanBeDealt [

	^ self amountOfUsedCards ~= 0 or: [ self amountOfCards ~= 0 ]
]

{ #category : #accessing }
OutstandingSpaceshipsGame >> cardsAffectingOf: aSpaceship [

	^ spaceshipsAffectingCardDeck select: [ :spaceshipCardDeck | 
		  spaceshipCardDeck spaceship = aSpaceship ]
]

{ #category : #properties }
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
					(SpaceshipCardHolder of: spaceship holding: deck dealCard) ] ] ]
]

{ #category : #palying }
OutstandingSpaceshipsGame >> dealCard [
	^ deck dealCard
]

{ #category : #accessing }
OutstandingSpaceshipsGame >> deckOf: aSpaceship [

	^ spaceshipsCardDeck select: [ :spaceshipCardDeck | 
		  spaceshipCardDeck spaceship = aSpaceship ]
]

{ #category : #initialization }
OutstandingSpaceshipsGame >> initializeWith: aBoard many: spaceships throwing: someDice using: aFiniteDeck [

	lastPlayedCard := ''.
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
	deckOfSpaceship := self cardsAffectingOf: board spaceshipPlaying.
	effectOnDiceThrow := self calculateEffectOnDiceThrowFor: deckOfSpaceship .
	board moveSpaceship: resultOfTheRoll + effectOnDiceThrow.
	self refillDeckIfEmpty.
	board thereIsAWinner
		ifTrue: [ stateOfGame := GameWonState new ]
]

{ #category : #playing }
OutstandingSpaceshipsGame >> refillDeckIfEmpty [

	deck cardAmount = 0 ifTrue: [ 
		deck reSetWith: usedCardsDeck shuffle.
		usedCardsDeck := OrderedCollection new ]
]

{ #category : #properties }
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
	self assertCardBelongsToSpaceship: cardToBeRemoved.
	self
		assertCardCanBeThrown: (spaceshipsCardDeck at: cardToBeRemoved) card
		from: aSpaceship.
	spaceshipsCardDeck removeAt: cardToBeRemoved.
	aCard incorporateTo: self
]

{ #category : #results }
OutstandingSpaceshipsGame >> winner [

	^ board winner
]

Class {
	#name : #Spaceship,
	#superclass : #Object,
	#instVars : [
		'name',
		'unplayedCards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Spaceship class >> assertValid: aPerson [

	aPerson isEmpty ifTrue: [ 
		Error signal: 'Spaceship has to be assigned to a valid player' ]
]

{ #category : #'instance creation' }
Spaceship class >> called: aName [

	self assertValid: aName.
	^ self new initializeCalling: aName
]

{ #category : #comparing }
Spaceship >> = anObject [

	^ self class = anObject class and: [ name = anObject name ]
]

{ #category : #asserting }
Spaceship >> assertAmountOfCardsIsValid: anAmount [

	anAmount < 0 ifTrue: [ 
		Error signal: 'Cannot select a card of index smaller than 1' ]
]

{ #category : #asserting }
Spaceship >> assertCardCanBeThrown: aCard in: aBoard [

	aBoard assertACardCanBeThrown.
	aCard assertItIsThrowableIfCurrentTurnBelongingToSpaceshipIs:
		(aBoard isSpaceshipsTurn: name)
]

{ #category : #asserting }
Spaceship >> assertSpaceshipHasNAmountOfCards: anAmount [

	unplayedCards isEmpty
		ifTrue: [ Error signal: 'The spaceship doesnt have cards to throw' ]
		ifFalse: [ 
			anAmount > unplayedCards size ifTrue: [ 
				Error signal:
					'The card selected is not in the spaceship card deck' ] ]
]

{ #category : #accessing }
Spaceship >> card [

	^ unplayedCards
]

{ #category : #comparing }
Spaceship >> hash [

	^ name hash
]

{ #category : #initialization }
Spaceship >> initializeCalling: aSpaceshipName [

	name := aSpaceshipName
]

{ #category : #properties }
Spaceship >> name [

	^ name
]

{ #category : #assignment }
Spaceship >> receives: aCard [

	self receivesMany: { aCard }
]

{ #category : #assignment }
Spaceship >> receivesMany: cards [

	unplayedCards := cards asOrderedCollection
]

{ #category : #'card throwing' }
Spaceship >> throw: BANANACard in: aBoard [ 
	
	| aCard |
	aCard := unplayedCards at: BANANACard.
	self assertCardCanBeThrown: aCard in: aBoard.
	unplayedCards removeAt: BANANACard.
	aBoard throw: aCard.
]

{ #category : #'card throwing' }
Spaceship >> throw: BANANACard to: aSpaceship in: aBoard [

	"assert de que hay n cartas en el arrreglo interno"

	| aCard |
	self assertAmountOfCardsIsValid: BANANACard.
	self assertSpaceshipHasNAmountOfCards: BANANACard.
	aCard := unplayedCards at: BANANACard.
	self assertCardCanBeThrown: aCard in: aBoard.
	unplayedCards removeAt: BANANACard.
	aBoard throw: aCard to: aSpaceship
]

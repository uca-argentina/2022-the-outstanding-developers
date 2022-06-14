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
Spaceship >> assertCardCanBeThrown: aCard in: aBoard [

	aCard assertItIsThrowableIfCurrentTurnBelongingToSpaceshipIs:
		(aBoard isSpaceshipsTurn: name)
]

{ #category : #accessing }
Spaceship >> cardDeck [

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
Spaceship >> throw: BANANACard to: aSpaceship in: aBoard [

	"assert de que hay n cartas en el arrreglo interno"

	| aCard |
	aCard := unplayedCards removeAt: BANANACard.
	self assertCardCanBeThrown: aCard in: aBoard.
	aBoard throw: aCard to: aSpaceship
]

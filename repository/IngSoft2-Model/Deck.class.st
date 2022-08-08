Class {
	#name : #Deck,
	#superclass : #Object,
	#instVars : [
		'cards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Deck class >> assertCardAmountIsNotNegative: aCardSequence [

	aCardSequence < 0 ifTrue: [ 
		Error signal: 'The card amount cant be a negative number' ]
]

{ #category : #'instance creation' }
Deck class >> empty [

	| cards |
	cards := OrderedCollection new.
	^ self new initializeWith: cards
]

{ #category : #'instance creation' }
Deck class >> of: aCardAmount setWith: aCardCollection [

	| cards sequenceHandler |
	self assertCardAmountIsNotNegative: aCardAmount.
	cards := OrderedCollection new.
	sequenceHandler := SequenceHandler for: aCardCollection size.
	aCardAmount timesRepeat: [ 
		cards add: (aCardCollection at: sequenceHandler nextValue) ].
	^ self new initializeWith: cards
]

{ #category : #'instance creation' }
Deck class >> of: aCardAmount with: aCardDistribution [

	| randomCardGenerator |
	self assertCardAmountIsNotNegative: aCardAmount.
	randomCardGenerator := RandomEventGenerator
		                       with: aCardAmount
		                       using: aCardDistribution.
	^ self new initializeWith: randomCardGenerator generate
]

{ #category : #'instance creation' }
Deck class >> setWith: aCardSequence [ 
	
	^self new initializeWith: aCardSequence 
]

{ #category : #playing }
Deck >> add: aCard [

	cards add: aCard
]

{ #category : #accessing }
Deck >> cardAmount [

	^ cards size
]

{ #category : #playing }
Deck >> dealCard [

	^ cards removeFirst
]

{ #category : #initialization }
Deck >> initializeWith: aSetOfCards [

	cards := aSetOfCards
]

{ #category : #actions }
Deck >> reSetWith: aSetOfCards [ 
	
	cards := aSetOfCards 
]

{ #category : #playing }
Deck >> shuffle [

	^ cards shuffle
]

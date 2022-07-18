Class {
	#name : #FiniteDeck,
	#superclass : #Object,
	#instVars : [
		'cards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
FiniteDeck class >> assertCardAmountIsNotNegative: aCardSequence [

	aCardSequence < 0 ifTrue: [ 
		Error signal: 'The card amount cant be a negative number' ]
]

{ #category : #'instance creation' }
FiniteDeck class >> of: aCardAmount setWith: aCardCollection [

	| cards sequenceHandler |
	self assertCardAmountIsNotNegative: aCardAmount.
	cards := OrderedCollection new.
	sequenceHandler := SequenceHandler for: aCardCollection size.
	aCardAmount timesRepeat: [ 
		cards add: (aCardCollection at: sequenceHandler nextValue) ].
	^ self new initializeWith: cards
]

{ #category : #'instance creation' }
FiniteDeck class >> of: aCardAmount with: aCardDistribution [

	| randomCardGenerator |
	self assertCardAmountIsNotNegative: aCardAmount.
	randomCardGenerator := RandomEventGenerator
		                       with: aCardAmount
		                       using: aCardDistribution.
	^ self new initializeWith: randomCardGenerator generate
]

{ #category : #'instance creation' }
FiniteDeck class >> setWith: aCardSequence [ 
	
	^self new initializeWith: aCardSequence 
]

{ #category : #accessing }
FiniteDeck >> cardAmount [

	^ cards size
]

{ #category : #playing }
FiniteDeck >> dealCard [

	^ cards removeFirst
]

{ #category : #initialization }
FiniteDeck >> initializeWith: aSetOfCards [

	cards := aSetOfCards
]

{ #category : #actions }
FiniteDeck >> reSetWith: aSetOfCards [ 
	
	cards := aSetOfCards 
]

Class {
	#name : #FiniteDeckTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
FiniteDeckTest >> should: block raise: expectedErrorClass withMessage: expectedErrorMessage [

	self
		should: block
		raise: expectedErrorClass
		whoseDescriptionIncludes: expectedErrorMessage
		description: 'Test did not failed as expected'
]

{ #category : #tests }
FiniteDeckTest >> testACardDealtFromAFiniteDeckOfCardsCreatedOfOverloadsIsAnOverloadCard [

	| finiteDeck aCardDistribution dealtCard |
	aCardDistribution := OrderedCollection new.
	aCardDistribution add:
		(Distribution withProbabilityOf: 1 for: OverloadCard).
	finiteDeck := Deck of: 5 with: aCardDistribution.
	dealtCard := finiteDeck dealCard.
	self assert: dealtCard name equals: 'Overload'
]

{ #category : #tests }
FiniteDeckTest >> testAFiniteDeckOfCardsCantBeCreatedWithANegativeNumberOfCards [

	| aCardDistribution |
	aCardDistribution := OrderedCollection new.
	aCardDistribution add:
		(Distribution withProbabilityOf: 1 for: OverloadCard).
	self
		should: [ Deck of: -3 with: aCardDistribution ]
		raise: Error
		withMessage: 'The card amount cant be a negative number'
]

{ #category : #tests }
FiniteDeckTest >> testAFiniteDeckOfCardsCreatedWithAsequenceOfFiveCardsHasInitiallyFiveCards [

	| finiteDeck aCardSequence |
	aCardSequence := OrderedCollection new.
	aCardSequence add: OverloadCard create.
	aCardSequence add: OverloadCard create.
	aCardSequence add: OverloadCard create.
	aCardSequence add: OverloadCard create.
	aCardSequence add: OverloadCard create.
	finiteDeck := Deck setWith: aCardSequence.
	self assert: finiteDeck cardAmount equals: 5
]

{ #category : #tests }
FiniteDeckTest >> testAFiniteDeckOfCardsCreatedWithAsequenceOfTwoCardsForATotalOfFiveCardsHasASpecificSequence [

	| finiteDeck aCardSequence |
	aCardSequence := OrderedCollection new.
	aCardSequence add: OverloadCard create.
	aCardSequence add: SpeedCard create.
	finiteDeck := Deck of: 5 setWith: aCardSequence.
	self assert: finiteDeck cardAmount equals: 5.
	self assert: finiteDeck dealCard name equals: 'Overload'.
	self assert: finiteDeck dealCard name equals: 'Speed'.
	self assert: finiteDeck dealCard name equals: 'Overload'.
	self assert: finiteDeck dealCard name equals: 'Speed'.
	self assert: finiteDeck dealCard name equals: 'Overload'
]

{ #category : #tests }
FiniteDeckTest >> testAFiniteDeckOfCardsCreatedWithFiveRandomCardsHasInitiallyFiveCards [

	| finiteDeck aCardDistribution |
	aCardDistribution := OrderedCollection new.
	aCardDistribution add:
		(Distribution withProbabilityOf: 1 for: OverloadCard).
	finiteDeck := Deck of: 5 with: aCardDistribution.
	self assert: finiteDeck cardAmount equals: 5
]

{ #category : #tests }
FiniteDeckTest >> testAFiniteDeckOfCardsHasOneCardLessAfterItIsDealt [

	| finiteDeck aCardDistribution dealtCard |
	aCardDistribution := OrderedCollection new.
	aCardDistribution add:
		(Distribution withProbabilityOf: 1 for: OverloadCard).
	finiteDeck := Deck of: 5 with: aCardDistribution.
	self assert: finiteDeck cardAmount equals: 5.

	dealtCard := finiteDeck dealCard.
	self assert: finiteDeck cardAmount equals: 4
]

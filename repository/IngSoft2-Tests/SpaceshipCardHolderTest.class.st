Class {
	#name : #SpaceshipCardHolderTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
SpaceshipCardHolderTest >> testSpaceshipHasOnePendingCardToPlay [
	
	| delorean aCard cardHolder |
	delorean := Spaceship called: 'Delorean'.
	aCard := OverloadCard new.
	cardHolder := SpaceshipCardHolder of: delorean holding: aCard.
	
	self assert: cardHolder unplayedCards equals: { aCard }.
]

{ #category : #tests }
SpaceshipCardHolderTest >> testSpaceshipHasTwoPendingCardsToPlay [

	| delorean cardHolder overloadCard speedCard cards |
	delorean := Spaceship called: 'Delorean'.
	overloadCard := OverloadCard new.
	speedCard := SpeedCard new.
	cards := { 
		         overloadCard.
		         speedCard }.
	cardHolder := SpaceshipCardHolder of: delorean holdingMany: cards.

	self assert: cardHolder unplayedCards equals: cards
]

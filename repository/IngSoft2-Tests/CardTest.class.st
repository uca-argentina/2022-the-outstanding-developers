Class {
	#name : #CardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
CardTest >> testOverloadCardReducesInTwoTheSpaceshipDiceThrow [

	| aCard enterprise aBoard delorean spaceshipsPlaying |
	aCard := OverloadCard new.
	enterprise := Spaceship called: 'Enterprise'.
	delorean := Spaceship called: 'Delorean'.
	aBoard := Board
		          of: 10
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          by: enterprise
		          with: { NoEffect new }.
	
"	spaceshipsPlaying := delorean meetOtherSpaceshipsIn: aBoard.
	delorean throw: aCard to: (spaceshipsPlaying at: 2) in: aBoard.
	aBoard moveSpaceship: 5.
	self assert: (aBoard positionOf: enterprise name) equals: 3"
]

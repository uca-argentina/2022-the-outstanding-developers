Class {
	#name : #BoxTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoxTest >> should: block raise: expectedErrorClass withMessage: expectedErrorMessage [

	self
		should: block
		raise: expectedErrorClass
		whoseDescriptionIncludes: expectedErrorMessage
		description: 'Test did not failed as expected'
]

{ #category : #tests }
BoxTest >> testBoxWithNoEffectDoesNotModifyPosition [

	| box anEffect |
	anEffect := NoEffect new.
	box := Box with: anEffect.
	self assert: box effectOnPosition equals: 0
]

{ #category : #tests }
BoxTest >> testCardAwarderBoxEffectDoesNotModifyPosition [

	| aBoard noEffect cardAwarderEffect boxSequence box1 box2 box3 box4 box5 aCardDistribution anOutstandingGame |
	aCardDistribution := OrderedCollection new.
	aCardDistribution add:
		(Distribution withProbabilityOf: 1 for: OverloadCard).
	noEffect := NoEffect new.
	cardAwarderEffect := CardAwarderEffect with: aCardDistribution.

	box1 := Box with: cardAwarderEffect.
	box2 := Box with: noEffect.
	box3 := Box with: noEffect.
	box4 := Box with: noEffect.
	box5 := Box with: noEffect.

	boxSequence := { 
		               box1.
		               box2.
		               box3.
		               box4.
		               box5 }.
	aBoard := Board
		          of: 10
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          with: boxSequence.

	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Enterprise'. 'Delorean' }
		                     on: aBoard
		                     throwing: (LoadedDie withSequence: { 4. 1 })
		                     using: aCardDistribution.
	anOutstandingGame play.
	anOutstandingGame play.

	self assert: (aBoard boxPositionOf: 'Enterprise') equals: 4.
	self assert: (aBoard lapOf: 'Enterprise') equals: 1.
	self assert: (aBoard boxPositionOf: 'Delorean') equals: 1.
	self assert: (aBoard lapOf: 'Delorean') equals: 1
]

{ #category : #tests }
BoxTest >> testCardAwarderBoxEffectGivesACardToTheSpaceshipThatLandsOnIt [

	| aBoard noEffect cardAwarderEffect boxSequence box1 box2 box3 box4 box5 aCardDistribution anOutstandingGame |
	aCardDistribution := OrderedCollection new.
	aCardDistribution add:
		(Distribution withProbabilityOf: 1 for: OverloadCard).
	noEffect := NoEffect new.
	cardAwarderEffect := CardAwarderEffect with: aCardDistribution.

	box1 := Box with: cardAwarderEffect.
	box2 := Box with: noEffect.
	box3 := Box with: noEffect.
	box4 := Box with: noEffect.
	box5 := Box with: noEffect.

	boxSequence := { 
		               box1.
		               box2.
		               box3.
		               box4.
		               box5 }.
	aBoard := Board
		          of: 10
		          and: (ParsecUnit of: 10)
		          playedFor: 1
		          with: boxSequence.

	anOutstandingGame := OutstandingSpaceshipsGame
		                     playedByMany: { 'Enterprise'. 'Delorean' }
		                     on: aBoard
		                     throwing: (LoadedDie with: 1)
		                     using: aCardDistribution.
	anOutstandingGame play.

	self assert: (anOutstandingGame deckOf: 'Enterprise') size equals: 3.
	self assert: (anOutstandingGame deckOf: 'Delorean') size equals: 2
]

{ #category : #tests }
BoxTest >> testHyperJumpBoxAutogeneratesASequence [

	| box anEffect firstEffect secondEffect |
	anEffect := HyperJumpEffect create.
	box := Box with: anEffect.
	firstEffect := box effectOnPosition.
	secondEffect := box effectOnPosition.
	self assert: firstEffect valueOfMeasurement > 0.
	self assert:
		secondEffect valueOfMeasurement <= firstEffect valueOfMeasurement
]

{ #category : #tests }
BoxTest >> testHyperJumpBoxCantBeCreatedWithAnEmptySequence [

	self
		should: [ HyperJumpEffect with: {  } ]
		raise: Error
		withMessage: 'Sequence size must be greater than zero'
]

{ #category : #tests }
BoxTest >> testHyperJumpBoxEffectDisplacesAListOfParsecsValuesRepeatedly [

	| box anEffect parsecsList |
	parsecsList := { 
		               (ParsecUnit of: 4).
		               (ParsecUnit of: 3).
		               (ParsecUnit of: 1).
		               (ParsecUnit of: 5) }.
	anEffect := HyperJumpEffect with: parsecsList.
	box := Box with: anEffect.
	self assert: box effectOnPosition valueOfMeasurement equals: 4.
	self assert: box effectOnPosition valueOfMeasurement equals: 3.
	self assert: box effectOnPosition valueOfMeasurement equals: 1.
	self assert: box effectOnPosition valueOfMeasurement equals: 5.
	self assert: box effectOnPosition valueOfMeasurement equals: 4
]

{ #category : #tests }
BoxTest >> testHyperJumpBoxEffectDisplacesFourParsecsForward [

	| box anEffect parsecsList |
	parsecsList := { (ParsecUnit of: 4) }.
	anEffect := HyperJumpEffect with: parsecsList.
	box := Box with: anEffect.
	self assert: box effectOnPosition valueOfMeasurement equals: 4
]

{ #category : #tests }
BoxTest >> testHyperJumpBoxEffectDisplacesSixLightYearsForward [

	| box anEffect lightYearList |
	lightYearList := { (LightYearUnit of: 6) }.
	anEffect := HyperJumpEffect with: lightYearList.
	box := Box with: anEffect.
	self assert: box effectOnPosition valueOfMeasurement equals: 6
]

{ #category : #tests }
BoxTest >> testMoonWalkBoxCantBeCreatedWithNegativeDisplacement [

	self
		should: [ MoonWalkEffect displacing: -8 ]
		raise: Error
		withMessage: 'MoonWalkBox displacement should be greater than zero'
]

{ #category : #tests }
BoxTest >> testMoonWalkBoxEffectDisplacesEightPlacesBackwards [

	| box anEffect |
	anEffect := MoonWalkEffect displacing: 8.
	box := Box with: anEffect.
	self assert: box effectOnPosition equals: -8
]

{ #category : #tests }
BoxTest >> testSpeedUpBoxEffectDisplacesFourPlacesForwards [

	| box anEffect |
	anEffect := SpeedUpEffect new.
	box := Box with: anEffect.
	self assert: box effectOnPosition equals: 4
]

{ #category : #tests }
BoxTest >> testWormHoleBoxEffectDisplacesFourPlacesBackwards [

	| box anEffect |
	anEffect := WormHoleEffect new.
	box := Box with: anEffect.
	self assert: box effectOnPosition equals: -4
]

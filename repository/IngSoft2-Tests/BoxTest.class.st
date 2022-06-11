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
BoxTest >> testHyperJumpBoxAutogeneratesAParsecSequence [

	| box anEffect firstEffect secondEffect |
	anEffect := HyperJumpEffect randomlyOf: 4.
	box := Box with: anEffect.
	firstEffect := box effectOnPosition.
	secondEffect := box effectOnPosition.
	self assert: firstEffect > 0.
	self assert: secondEffect <= firstEffect
]

{ #category : #tests }
BoxTest >> testHyperJumpBoxAutogenerationParsecSequenceMustBeGreaterThanZero [

	self
		should: [ HyperJumpEffect randomlyOf: 0 ]
		raise: Error
		withMessage: 'Parsec sequence size must be greater than zero'
]

{ #category : #tests }
BoxTest >> testHyperJumpBoxEffectDisplacesAListOfParsecsValuesRepeatedly [

	| box anEffect parsecsList |
	parsecsList := { 4. 3. 1. 5 }.
	anEffect := HyperJumpEffect with: parsecsList.
	box := Box with: anEffect.
	self assert: box effectOnPosition equals: 4.
	self assert: box effectOnPosition equals: 3.
	self assert: box effectOnPosition equals: 1.
	self assert: box effectOnPosition equals: 5.
	self assert: box effectOnPosition equals: 4
]

{ #category : #tests }
BoxTest >> testHyperJumpBoxEffectDisplacesFourParsecsForward [

	| box anEffect parsecsList |
	parsecsList := { 4 }.
	anEffect := HyperJumpEffect with: parsecsList.
	box := Box with: anEffect.
	self assert: box effectOnPosition equals: 4
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

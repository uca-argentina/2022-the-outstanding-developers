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
BoxTest >> testHyperJumpBoxAutogeneratesASequence [

	| box anEffect firstEffect secondEffect |
	anEffect := HyperJumpEffect create.
	box := Box with: anEffect.
	firstEffect := box effectOnPosition.
	secondEffect := box effectOnPosition.
	self assert: firstEffect > 0.
	self assert: secondEffect <= firstEffect
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
	parsecsList := { ParsecUnit of: 4. ParsecUnit of: 3. ParsecUnit of: 1. ParsecUnit of: 5 }.
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
	parsecsList := { ParsecUnit of: 4 }.
	anEffect := HyperJumpEffect with: parsecsList.
	box := Box with: anEffect.
	self assert: box effectOnPosition equals: 4
]

{ #category : #tests }
BoxTest >> testHyperJumpBoxEffectDisplacesSixLightYearsForward [

	| box anEffect lightYearList |
	lightYearList := { LightYearUnit of: 6 }.
	anEffect := HyperJumpEffect with: lightYearList.
	box := Box with: anEffect.
	self assert: box effectOnPosition equals: 6
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

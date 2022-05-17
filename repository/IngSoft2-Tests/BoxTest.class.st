Class {
	#name : #BoxTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoxTest >> testHyperJumpBoxEffectDisplacesAListOfParsecsValuesRepeatedly [

	| box aHyperJump parsecsList |
	parsecsList := { 4. 3. 1. 5 }.
	aHyperJump := HyperJump with: parsecsList.
	box := Box withEffect: aHyperJump.
	self assert: box effectOnPosition equals: 4.
	self assert: box effectOnPosition equals: 3.
	self assert: box effectOnPosition equals: 1.
	self assert: box effectOnPosition equals: 5.
	self assert: box effectOnPosition equals: 4
]

{ #category : #tests }
BoxTest >> testHyperJumpBoxEffectDisplacesFourParsecsForward [

	| box aHyperJump parsecsList |
	parsecsList := { 4 }.
	aHyperJump := HyperJump with: parsecsList.
	box := Box withEffect: aHyperJump.
	self assert: box effectOnPosition equals: 4
]

{ #category : #tests }
BoxTest >> testMoonWalkBoxEffectDisplacesEightPlacesBackwards [

	| box aMoonWalk |
	aMoonWalk := MoonWalkBox displacing: 8.
	box := Box withEffect: aMoonWalk.
	self assert: box effectOnPosition equals: -8
]

{ #category : #tests }
BoxTest >> testNormalBoxEffectOnPositionIsZero [

	| box aNormalBox |
	aNormalBox := NormalBox new.
	box := Box withEffect: aNormalBox.
	self assert: box effectOnPosition equals: 0
]

{ #category : #tests }
BoxTest >> testSpeedUpBoxEffectDisplacesFourPlacesForwards [

	| box speedUpBox |
	speedUpBox := SpeedUpBox new.
	box := Box withEffect: speedUpBox.
	self assert: box effectOnPosition equals: 4
]

{ #category : #tests }
BoxTest >> testWormHoleBoxEffectDisplacesFourPlacesBackwards [

	| box aHyperJump |
	aHyperJump := WormHoleBox new.
	box := Box withEffect: aHyperJump.
	self assert: box effectOnPosition equals: -4
]

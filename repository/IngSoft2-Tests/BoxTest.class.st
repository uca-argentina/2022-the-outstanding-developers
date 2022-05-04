Class {
	#name : #BoxTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

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

	| box aWormHole |
	aWormHole := WormHoleBox new.
	box := Box withEffect: aWormHole.
	self assert: box effectOnPosition equals: -4
]

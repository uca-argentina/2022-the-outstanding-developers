Class {
	#name : #TurnHandler,
	#superclass : #Object,
	#instVars : [
		'numberOfSpaceships',
		'currentSpaceshipToMove'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
TurnHandler class >> with: numberOfSpaceships [ 
	^self new initializeWith: numberOfSpaceships.
]

{ #category : #initialization }
TurnHandler >> initializeWith: aNumberOfSpaceships [ 
	numberOfSpaceships := aNumberOfSpaceships.
	currentSpaceshipToMove := 1.
]

{ #category : #turns }
TurnHandler >> spaceshipToMove [
	
	| spaceshipTurnBANANA |
	spaceshipTurnBANANA := currentSpaceshipToMove.
	currentSpaceshipToMove := (currentSpaceshipToMove rem: numberOfSpaceships) + 1.
	^spaceshipTurnBANANA.
]

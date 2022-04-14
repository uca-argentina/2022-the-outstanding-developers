Class {
	#name : #SpaceshipTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
SpaceshipTest >> testSpaceshipCannotBeCreatedWithEmptyPlayer [
	
	self 
		should: [ Spaceship assignedTo: '' ]
		raise: Error 
		whoseDescriptionIncludes: 'Spaceship has to be assigned to a valid player'
		description: 'Test did not failed as expected'
	
]

{ #category : #tests }
SpaceshipTest >> testSpaceshipCreatedWithPlayerNameIsValid [

	| spaceship playerName|
	playerName := 'SomePlayer'.
	spaceship := Spaceship assignedTo: playerName.
	self assert: spaceship player identicalTo: playerName
]

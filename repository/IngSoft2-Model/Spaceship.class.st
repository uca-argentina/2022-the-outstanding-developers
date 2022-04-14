Class {
	#name : #Spaceship,
	#superclass : #Object,
	#instVars : [
		'player'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Spaceship class >> assertValid: aPerson [
	(aPerson size > 0) ifFalse: [ Error signal: 'Spaceship has to be assigned to a valid player' ]
]

{ #category : #asserting }
Spaceship class >> assignedTo: aPlayer [
	self assertValid: aPlayer.
	^self new initializeWith: aPlayer
	
]

{ #category : #initialization }
Spaceship >> initializeWith: aPlayer [ 
	player := aPlayer 
]

{ #category : #properties }
Spaceship >> player [
	^ player
]

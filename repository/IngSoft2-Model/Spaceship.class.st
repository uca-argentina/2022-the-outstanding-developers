Class {
	#name : #Spaceship,
	#superclass : #Object,
	#instVars : [
		'player',
		'diceCup'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Spaceship class >> assertValid: aPerson [
	(aPerson size > 0) ifFalse: [ Error signal: 'Spaceship has to be assigned to a valid player' ]
]

{ #category : #initialization }
Spaceship class >> assignedTo: aPlayer with: aDice [ 
	self assertValid: aPlayer.
	^self new initializeWith: aPlayer and: aDice
]

{ #category : #initialization }
Spaceship >> addDie: aDie [ 
	diceCup := DiceCup withAll: { diceCup. aDie }.
]

{ #category : #initialization }
Spaceship >> initializeWith: aPlayer and: aDice [
	player := aPlayer.
	diceCup := aDice.
]

{ #category : #playing }
Spaceship >> play [
	^diceCup roll.
]

{ #category : #properties }
Spaceship >> player [
	^ player
]

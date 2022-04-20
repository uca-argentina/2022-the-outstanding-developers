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

	aPerson isEmpty ifTrue: [ 
		Error signal: 'Spaceship has to be assigned to a valid player' ]
]

{ #category : #'instance creation' }
Spaceship class >> assignedTo: aPlayerName [

	self assertValid: aPlayerName.
	^ self new initializeWith: aPlayerName
]

{ #category : #comparing }
Spaceship >> = anObject [

	^ self class = anObject class and: [ player = anObject player ]
]

{ #category : #comparing }
Spaceship >> hash [

	^ player hash
]

{ #category : #initialization }
Spaceship >> initializeWith: aPlayerName [

	player := aPlayerName
]

{ #category : #properties }
Spaceship >> player [

	^ player
]

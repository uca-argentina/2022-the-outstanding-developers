Class {
	#name : #Spaceship,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Spaceship class >> assertValid: aPerson [

	aPerson isEmpty ifTrue: [ 
		Error signal: 'Spaceship has to be assigned to a valid player' ]
]

{ #category : #'instance creation' }
Spaceship class >> called: aName [

	self assertValid: aName.
	^ self new initializeCalling: aName
]

{ #category : #comparing }
Spaceship >> = anObject [

	^ self class = anObject class and: [ name = anObject name ]
]

{ #category : #comparing }
Spaceship >> hash [

	^ name hash
]

{ #category : #initialization }
Spaceship >> initializeCalling: aSpaceshipName [

	name := aSpaceshipName
]

{ #category : #properties }
Spaceship >> name [

	^ name
]

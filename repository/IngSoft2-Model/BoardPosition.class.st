Class {
	#name : #BoardPosition,
	#superclass : #Object,
	#instVars : [
		'position',
		'spaceship'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
BoardPosition class >> following: aSpaceship [ 
	^self new initializeFollowing: aSpaceship
]

{ #category : #'instance creation' }
BoardPosition class >> following: aSpaceship at: aPosition [ 

	^self new initializeFollowing: aSpaceship at: aPosition. 
]

{ #category : #initialization }
BoardPosition >> initializeFollowing: aSpaceshipName [

	spaceship := aSpaceshipName.
	position := 0
]

{ #category : #initialization }
BoardPosition >> initializeFollowing: aSpaceship at: aPosition [
	
	spaceship := aSpaceship.
	position := aPosition.
]

{ #category : #accessing }
BoardPosition >> position [

	^ position
]

{ #category : #accessing }
BoardPosition >> spaceship [

	^ spaceship
]

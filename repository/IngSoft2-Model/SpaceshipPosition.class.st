Class {
	#name : #SpaceshipPosition,
	#superclass : #Object,
	#instVars : [
		'spaceship',
		'boardPosition'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SpaceshipPosition class >> following: aSpaceship [

	| boardPosition |
	boardPosition := BoardPosition at: 0 in: 1.
	^ self new initializeFollowing: aSpaceship at: boardPosition
]

{ #category : #'instance creation' }
SpaceshipPosition class >> following: aSpaceship at: aBoardPosition [

	^ self new initializeFollowing: aSpaceship at: aBoardPosition
]

{ #category : #comparing }
SpaceshipPosition >> > aSpaceshipPosition [

	^ boardPosition > aSpaceshipPosition boardPosition
]

{ #category : #accessing }
SpaceshipPosition >> boardPosition [
	^ boardPosition
]

{ #category : #initialization }
SpaceshipPosition >> initializeFollowing: aSpaceship at: aBoardPosition [

	spaceship := aSpaceship.
	boardPosition := aBoardPosition
]

{ #category : #accessing }
SpaceshipPosition >> lap [

	^ boardPosition lap
]

{ #category : #accessing }
SpaceshipPosition >> position [

	^ boardPosition position
]

{ #category : #accessing }
SpaceshipPosition >> spaceship [

	^ spaceship
]

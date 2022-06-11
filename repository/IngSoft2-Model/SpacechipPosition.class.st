Class {
	#name : #SpacechipPosition,
	#superclass : #Object,
	#instVars : [
		'position',
		'spaceship',
		'lap',
		'boardPosition'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SpacechipPosition class >> following: aSpaceship [

	| boardPosition |
	boardPosition := BoardPosition at: 0 in: 1.
	^ self new initializeFollowing: aSpaceship at: boardPosition
]

{ #category : #'instance creation' }
SpacechipPosition class >> following: aSpaceship at: aBoardPosition [

	^ self new initializeFollowing: aSpaceship at: aBoardPosition
]

{ #category : #comparing }
SpacechipPosition >> > aSpaceshipPosition [

	^ boardPosition > aSpaceshipPosition boardPosition
]

{ #category : #accessing }
SpacechipPosition >> boardPosition [
	^ boardPosition
]

{ #category : #initialization }
SpacechipPosition >> initializeFollowing: aSpaceship at: aBoardPosition [

	spaceship := aSpaceship.
	boardPosition := aBoardPosition
]

{ #category : #accessing }
SpacechipPosition >> lap [

	^ boardPosition lap
]

{ #category : #accessing }
SpacechipPosition >> position [

	^ boardPosition position
]

{ #category : #accessing }
SpacechipPosition >> spaceship [

	^ spaceship
]

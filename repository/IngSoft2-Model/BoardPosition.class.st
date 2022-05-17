Class {
	#name : #BoardPosition,
	#superclass : #Object,
	#instVars : [
		'position',
		'spaceship',
		'lap'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
BoardPosition class >> following: aSpaceship [

	^self new initializeFollowing: aSpaceship
]

{ #category : #'instance creation' }
BoardPosition class >> following: aSpaceship at: aPosition in: aLap [

	^self new initializeFollowing: aSpaceship at: aPosition in: aLap. 
]

{ #category : #initialization }
BoardPosition >> initializeFollowing: aSpaceshipName [

	spaceship := aSpaceshipName.
	lap := 1.
	position := 0
]

{ #category : #initialization }
BoardPosition >> initializeFollowing: aSpaceship at: aPosition in: aLap [

	spaceship := aSpaceship.
	position := aPosition > 0
		            ifFalse: [ 1 ]
		            ifTrue: [ aPosition ].
	lap := aLap
]

{ #category : #accessing }
BoardPosition >> lap [

	^ lap
]

{ #category : #accessing }
BoardPosition >> position [

	^ position
]

{ #category : #accessing }
BoardPosition >> spaceship [

	^ spaceship
]

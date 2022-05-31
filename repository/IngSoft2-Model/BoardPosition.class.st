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

	^self new initializeFollowing: aSpaceship at: 0 in: 1
]

{ #category : #'instance creation' }
BoardPosition class >> following: aSpaceship at: aPosition in: aLap [

	| validatedPosition |
	validatedPosition := ((aPosition = 0 and: [ aLap > 1 ]) or:
		                      aPosition < 0)
		                     ifTrue: [ 1 ]
		                     ifFalse: [ aPosition ].
	^ self new
		  initializeFollowing: aSpaceship
		  at: validatedPosition
		  in: aLap
]

{ #category : #comparing }
BoardPosition >> > aBoardPosition [

	self lap > aBoardPosition lap
		ifFalse: [ 
			^ self lap = aBoardPosition lap and: [ 
				  self position > aBoardPosition position ] ].
	^true
]

{ #category : #initialization }
BoardPosition >> initializeFollowing: aSpaceship at: aPosition in: aLap [

	spaceship := aSpaceship.
	position := aPosition.
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

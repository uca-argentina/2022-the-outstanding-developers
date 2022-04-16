Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameTest >> testStartAGame [
	Game start.
]

{ #category : #tests }
GameTest >> testStartAGameWithABoard [

	|aBoard game|
	aBoard := Board with: 10.
	game := Game with: aBoard.
	
]

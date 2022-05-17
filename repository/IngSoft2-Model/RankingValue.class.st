Class {
	#name : #RankingValue,
	#superclass : #Object,
	#instVars : [
		'spaceship',
		'absolutePosition'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
RankingValue class >> of: aBoardPosition withSize: aSize [
	^self new of: aBoardPosition withSize: aSize 
]

{ #category : #accessing }
RankingValue >> absolutePosition [
	^ absolutePosition
]

{ #category : #initialization }
RankingValue >> of: aBoardPosition withSize: aSize [
	spaceship := aBoardPosition spaceship.
	absolutePosition := aBoardPosition lap * aSize + aBoardPosition position 
]

{ #category : #accessing }
RankingValue >> spaceship [
	^ spaceship
]

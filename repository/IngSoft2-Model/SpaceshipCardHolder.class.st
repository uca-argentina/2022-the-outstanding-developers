Class {
	#name : #SpaceshipCardHolder,
	#superclass : #Object,
	#instVars : [
		'spaceship',
		'cardDeck'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SpaceshipCardHolder class >> of: aSpaceship holding: aCard [ 
	
	^ self new of: aSpaceship holdingMany: {aCard}
]

{ #category : #'instance creation' }
SpaceshipCardHolder class >> of: aSpaceship holdingMany: cards [ 
	
	^ self new of: aSpaceship holdingMany: cards
]

{ #category : #'card deck modifying' }
SpaceshipCardHolder >> add: aCard [

	cardDeck add: aCard
]

{ #category : #accessing }
SpaceshipCardHolder >> cardDeck [

	^ cardDeck 
]

{ #category : #initialization }
SpaceshipCardHolder >> of: aSpaceship holdingMany: cards [

	spaceship := aSpaceship.
	cardDeck := OrderedCollection new.
	cards do: [ :card | cardDeck add: card ]
]

{ #category : #accessing }
SpaceshipCardHolder >> spaceship [

	^ spaceship
]

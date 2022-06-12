Class {
	#name : #SpaceshipCardHolder,
	#superclass : #Object,
	#instVars : [
		'spaceship',
		'cardsDeck'
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

{ #category : #initialization }
SpaceshipCardHolder >> of: aSpaceship holdingMany: cards [

	spaceship := aSpaceship.
	cardsDeck := cards
]

{ #category : #accessing }
SpaceshipCardHolder >> unplayedCards [

	^ cardsDeck 
]

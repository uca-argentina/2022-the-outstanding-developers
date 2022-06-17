Class {
	#name : #RedoCard,
	#superclass : #Object,
	#instVars : [
		'card'
	],
	#classInstVars : [
		'target',
		'lastPlayedCard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
RedoCard class >> addTo: anOutstandingSpaceshipsGame [ 
	
	lastPlayedCard incorporateTo: anOutstandingSpaceshipsGame theElement: self.
]

{ #category : #initialization }
RedoCard class >> create [

	^ self new initializeWithCard: EmptyCard new
]

{ #category : #'instance creation' }
RedoCard class >> createWithCard [

	^ self new initializeWithCard: lastPlayedCard
]

{ #category : #playing }
RedoCard class >> incorporateTo: anOutstandingSpaceshipsGame [ 

	lastPlayedCard := anOutstandingSpaceshipsGame lastPlayedCard.
	lastPlayedCard cardBehaviour incorporate: self To: anOutstandingSpaceshipsGame  
]

{ #category : #playing }
RedoCard class >> playOnceIn: anOutstandingSpaceshipsGame [

	lastPlayedCard incorporateTo: anOutstandingSpaceshipsGame theElement: self.
]

{ #category : #accessing }
RedoCard class >> target [

	^ target
]

{ #category : #playing }
RedoCard class >> thrownAt: aTarget [

	target := aTarget
]

{ #category : #comparing }
RedoCard >> = aCard [

	^ self class = aCard
]

{ #category : #assertions }
RedoCard >> assertItIsThrowableInTurn: anAssertion in: anOutstandingSpaceshipsGame [

	^ true
]

{ #category : #accessing }
RedoCard >> card [

	^ card
]

{ #category : #effect }
RedoCard >> effectOnThrow [

	^ card effectOnThrow
]

{ #category : #initialization }
RedoCard >> initializeWithCard: aCard [

	card := aCard
]

{ #category : #accessing }
RedoCard >> name [

	^ 'Redo'
]

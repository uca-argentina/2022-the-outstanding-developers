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
	"anOutstandingSpaceshipsGame addAffecting: (SpaceshipCardHolder of: target holding: self createWithCard )"
	lastPlayedCard incorporateTo: anOutstandingSpaceshipsGame theElement: self.
]

{ #category : #initialization }
RedoCard class >> create [

	^ self new initializeWithCard: EmptyCard new
]

{ #category : #'instance creation' }
RedoCard class >> createWithCard [
	^self new initializeWithCard: lastPlayedCard
]

{ #category : #playing }
RedoCard class >> incorporateTo: anOutstandingSpaceshipsGame [ 

	lastPlayedCard := anOutstandingSpaceshipsGame lastPlayedCard.
	lastPlayedCard cardBehaviour incorporate: self To: anOutstandingSpaceshipsGame  
]

{ #category : #accessing }
RedoCard class >> target [
	^ target
]

{ #category : #playing }
RedoCard class >> thrownAt: aTarget [

	target := aTarget
]

{ #category : #playing }
RedoCard class >> thrownAt: aString or: aString2 [ 
	self shouldBeImplemented.
]

{ #category : #comparing }
RedoCard >> = aCard [

	^ self class = aCard
]

{ #category : #assertions }
RedoCard >> assertItIsThrowableInTurn: anAssertion in: anOutstandingSpaceshipsGame [

	^ true
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

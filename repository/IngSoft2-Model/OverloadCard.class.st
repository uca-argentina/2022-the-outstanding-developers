Class {
	#name : #OverloadCard,
	#superclass : #Object,
	#instVars : [
		'typeOfCard',
		'name',
		'target'
	],
	#classInstVars : [
		'typeOfCard',
		'spaceship'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
OverloadCard class >> create [

	^ self new initializeAs: PermanentCard new
]

{ #category : #'instance creation' }
OverloadCard class >> identifiedAs: aName thrownAt: aSpaceship [

	^ self new
		  initializeNamed: aName
		  aimedAt: aSpaceship
		  asA: PermanentCard new
]

{ #category : #playing }
OverloadCard class >> isAppliedTo: aSpaceship [

	^ spaceship = aSpaceship
]

{ #category : #accessing }
OverloadCard class >> spaceship [

	^ spaceship
]

{ #category : #comparing }
OverloadCard >> = aCard [

	^ self class = aCard class and: [ name = aCard identification ]
]

{ #category : #playing }
OverloadCard >> addAffecting: aCard to: aGame [

	aGame add: aCard affecting: self
]

{ #category : #playing }
OverloadCard >> addTo: aGame [

	aGame addAffecting: (SpaceshipHoldingACard of: target holding: self)
]

{ #category : #asserting }
OverloadCard >> assertItIsThrowableInTurn: anAssertion in: aGame [

	typeOfCard canBeThrownWithCurrentTurnBeing: anAssertion
]

{ #category : #playing }
OverloadCard >> cancelIn: aGame [

	aGame cancel: self
]

{ #category : #accessing }
OverloadCard >> cardBehaviour [

	^ typeOfCard
]

{ #category : #effect }
OverloadCard >> effectOnThrow [

	^ -2
]

{ #category : #acessing }
OverloadCard >> identification [

	^ name
]

{ #category : #playing }
OverloadCard >> incorporate: aCard to: aGame [ 
	
	self cardBehaviour incorporate: aCard to: aGame
]

{ #category : #playing }
OverloadCard >> incorporateTo: aGame [

	typeOfCard incorporate: self to: aGame
]

{ #category : #initialization }
OverloadCard >> initializeAs: aTypeOfCard [

	typeOfCard := aTypeOfCard
]

{ #category : #initialization }
OverloadCard >> initializeNamed: aName aimedAt: aSpaceship asA: aTypeOfCard [

	name := aName.
	target := aSpaceship.
	typeOfCard := aTypeOfCard
]

{ #category : #acessing }
OverloadCard >> isPermanent [

	^ true
]

{ #category : #accessing }
OverloadCard >> name [

	^ 'Overload'
]

{ #category : #playing }
OverloadCard >> reIncorporateTo: aGame the: selectedCard [

	| cardHolder |
	cardHolder := SpaceshipHoldingACard
		              of: selectedCard target
		              holding:
		              (OverloadCard
			               identifiedAs: 'r' , name
			               thrownAt: target).
	aGame addAffecting: cardHolder
]

{ #category : #accessing }
OverloadCard >> target [

	^ target
]

{ #category : #accessing }
OverloadCard >> typeOfCard [

	^ typeOfCard name
]

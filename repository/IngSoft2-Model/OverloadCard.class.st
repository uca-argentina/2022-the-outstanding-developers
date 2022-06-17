Class {
	#name : #OverloadCard,
	#superclass : #Object,
	#instVars : [
		'typeOfCard'
	],
	#classInstVars : [
		'typeOfCard',
		'spaceship'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
OverloadCard class >> addTo: anOutstandingSpaceshipsGame [ 
	anOutstandingSpaceshipsGame addAffecting: (SpaceshipCardHolder of: spaceship holding: self create )
]

{ #category : #'instance creation' }
OverloadCard class >> asA: aTypeOfCard [

	^self new initializeAs: aTypeOfCard
]

{ #category : #'class ini' }
OverloadCard class >> behavingAsA: aTypeOfCard [

	typeOfCard := aTypeOfCard
]

{ #category : #playing }
OverloadCard class >> cancelIn: anOutstandingSpaceshipsGame [ 
	anOutstandingSpaceshipsGame cancel: 'Overload' affecting: spaceship 
]

{ #category : #'class initialization' }
OverloadCard class >> cardName [

	^ 'Overload'
]

{ #category : #'instance creation' }
OverloadCard class >> create [

	^ self new initializeAs: typeOfCard  new
]

{ #category : #playing }
OverloadCard class >> incorporateTo: anOutstandingSpaceshipsGame [ 
	| aTypeOfCard |
	aTypeOfCard := typeOfCard new.
	aTypeOfCard incorporate: self To: anOutstandingSpaceshipsGame.
]

{ #category : #accessing }
OverloadCard class >> spaceship [

	^ spaceship
]

{ #category : #throwing }
OverloadCard class >> thrownAt: aSpaceship [ 
	
	spaceship := aSpaceship.
]

{ #category : #'class initialization' }
OverloadCard class >> thrownAt: aSpaceship asA: cardType [ 
	spaceship := aSpaceship.
	typeOfCard := cardType 
]

{ #category : #initialization }
OverloadCard >> = aCard [

	^ self class = aCard
]

{ #category : #asserting }
OverloadCard >> assertItIsThrowableIfCurrentTurnBelongingToSpaceshipIs: anAssertion [

	typeOfCard canBeThrownWithCurrentTurn: anAssertion
]

{ #category : #assertion }
OverloadCard >> assertItIsThrowableInTurn: anAssertion in: anOutstandingSpaceshipsGame [ 
	self assertItIsThrowableIfCurrentTurnBelongingToSpaceshipIs: anAssertion.
]

{ #category : #accessing }
OverloadCard >> cardBehaviour [

	^ typeOfCard
]

{ #category : #effect }
OverloadCard >> effectOnThrow [

	^ -2
]

{ #category : #playing }
OverloadCard >> incorporateTo: anOutstandingSpaceshipsGame theElement: aCard [ 
	| cardHolder |
	cardHolder := SpaceshipCardHolder of: aCard target holding: ((aCard createWithCard) card).
	anOutstandingSpaceshipsGame addAffecting: cardHolder
]

{ #category : #initialization }
OverloadCard >> initializeAs: aTypeOfCard [

	typeOfCard := aTypeOfCard
]

{ #category : #initialization }
OverloadCard >> name [

	^ 'Overload'
]

{ #category : #effect }
OverloadCard >> typeOfCard [

	^ typeOfCard name
]

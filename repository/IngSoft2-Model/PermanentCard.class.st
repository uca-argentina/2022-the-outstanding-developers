Class {
	#name : #PermanentCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #validation }
PermanentCard >> canBeThrownWithCurrentTurnBeing: anAssertion [

	anAssertion ifFalse: [ 
		Error signal:
			'Permanent cards can only be thrown in spaceships turn' ]
]

{ #category : #playing }
PermanentCard >> incorporate: aCard to: aGame [

	aCard addTo: aGame
]

{ #category : #accessing }
PermanentCard >> name [

	^ 'Permanent'
]

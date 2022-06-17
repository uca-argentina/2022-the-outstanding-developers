Class {
	#name : #PermanentCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #validation }
PermanentCard >> canBeThrownWithCurrentTurn: isCurrentTurn [

	isCurrentTurn ifFalse: [ 
		Error signal:
			'Permanent cards can only be thrown in spaceships turn' ]
]

{ #category : #playing }
PermanentCard >> incorporate: aCard To: anOutstandingSpaceshipsGame [ 
	aCard addTo: anOutstandingSpaceshipsGame
]

{ #category : #accessing }
PermanentCard >> name [

	^ 'Permanent'
]

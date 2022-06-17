Class {
	#name : #RedoCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
RedoCard class >> create [

	^ self new
]

{ #category : #effect }
RedoCard >> effectOnThrow [
	^0
]

{ #category : #accessing }
RedoCard >> name [

	^ 'Redo'
]

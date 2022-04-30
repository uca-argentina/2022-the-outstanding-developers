Class {
	#name : #SequenceHandlerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
SequenceHandlerTest >> testATurnHandlerInitializedWithThreeFourthTurnIsOne [

	| turnHandler |
	turnHandler := SequenceHandler for: 3.
	turnHandler index.
	turnHandler index.
	turnHandler index.
	self assert: turnHandler index equals: 1.
]

{ #category : #tests }
SequenceHandlerTest >> testATurnHandlerInitializedWithThreeThirdTurnIsThree [

	| turnHandler |
	turnHandler := SequenceHandler for: 3.
	turnHandler index.
	turnHandler index.
	self assert: turnHandler index equals: 3.
]

{ #category : #tests }
SequenceHandlerTest >> testFirstTurnIsOne [

	| turnHandler |
	turnHandler := SequenceHandler for: 3.
	self assert: turnHandler index equals: 1.
]

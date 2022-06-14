Class {
	#name : #SequenceHandlerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
SequenceHandlerTest >> testATurnHandlerInitializedWithThreeFourthTurnIsOne [

	| turnHandler |
	turnHandler := SequenceHandler for: 3.
	turnHandler nextValue.
	turnHandler nextValue.
	turnHandler nextValue.
	self assert: turnHandler nextValue equals: 1
]

{ #category : #tests }
SequenceHandlerTest >> testATurnHandlerInitializedWithThreeThirdTurnIsThree [

	| turnHandler |
	turnHandler := SequenceHandler for: 3.
	turnHandler nextValue.
	turnHandler nextValue.
	self assert: turnHandler nextValue equals: 3
]

{ #category : #tests }
SequenceHandlerTest >> testFirstTurnIsOne [

	| turnHandler |
	turnHandler := SequenceHandler for: 3.
	self assert: turnHandler nextValue equals: 1
]

{ #category : #tests }
SequenceHandlerTest >> testSequenceHandlerReturnsCurrentIndexWithoutIncrementingIndex [

	| turnHandler |
	turnHandler := SequenceHandler for: 3.
	turnHandler nextValue.
	self assert: turnHandler currentIndex equals: 2.
	turnHandler nextValue.
	self assert: turnHandler currentIndex equals: 3
]

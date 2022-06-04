Class {
	#name : #RandomEventGeneratorTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
RandomEventGeneratorTest >> should: block raise: expectedErrorClass withMessage: expectedErrorMessaje [

	self
		should: block
		raise: expectedErrorClass
		whoseDescriptionIncludes: expectedErrorMessaje
		description: 'Test did not failed as expected'
]

{ #category : #tests }
RandomEventGeneratorTest >> testGeneratorCannotBeCreatedIfTheSumOfProbabilitiesIsDifferenteToOne [

	| distributions |
	distributions := OrderedCollection new.
	distributions add:
		(Distribution withProbabilityOf: 0.4 for: NoEffect).
	distributions add:
		(Distribution withProbabilityOf: 0.2 for: SpeedUpEffect).
	self
		should: [ RandomEventGenerator with: 100 using: distributions ]
		raise: Error
		withMessage: 'Probabilities of the distribution must add up to one'
]

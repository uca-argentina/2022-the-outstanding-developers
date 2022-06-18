Class {
	#name : #DistributionTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
DistributionTest >> should: block raise: expectedErrorClass withMessage: expectedErrorMessaje [

	self
		should: block
		raise: expectedErrorClass
		whoseDescriptionIncludes: expectedErrorMessaje
		description: 'Test did not failed as expected'
]

{ #category : #tests }
DistributionTest >> testDistributionCannotBeCreatedIfTheProbabilityIsGreaterThanOne [

	self
		should: [ Distribution withProbabilityOf: 2 for: NoEffect ]
		raise: Error
		withMessage: 'Probabilities must be between zero and one'
]

{ #category : #tests }
DistributionTest >> testDistributionCannotBeCreatedIfTheProbabilityIsNegative [

	self
		should: [ Distribution withProbabilityOf: -10 for: NoEffect ]
		raise: Error
		withMessage: 'Probabilities must be between zero and one'
]

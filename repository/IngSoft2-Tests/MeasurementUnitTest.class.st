Class {
	#name : #MeasurementUnitTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
MeasurementUnitTest >> should: block raise: expectedErrorClass withMessage: expectedErrorMessage [

	self
		should: block
		raise: expectedErrorClass
		whoseDescriptionIncludes: expectedErrorMessage
		description: 'Test did not failed as expected'


]

{ #category : #tests }
MeasurementUnitTest >> testLightYearUnitCannotBeNegative [

	self
		should: [ LightYearUnit of: -1 ]
		raise: Error
		withMessage: 'Units cannot be negative'
]

{ #category : #tests }
MeasurementUnitTest >> testLightYearUnitConvertsSixLightYearsToTwoParsecs [

	| aLightYearUnit |
	aLightYearUnit := LightYearUnit of: 6.
	self assert: aLightYearUnit inParsecs equals: 2
]

{ #category : #tests }
MeasurementUnitTest >> testLightYearUnitHasAValueInLightYears [

	| aLightYearUnit |
	aLightYearUnit := LightYearUnit of: 6.
	self assert: aLightYearUnit inLightYears equals: 6
]

{ #category : #tests }
MeasurementUnitTest >> testParsecUnitCannotBeNegative [

	self
		should: [ ParsecUnit of: -1 ]
		raise: Error
		withMessage: 'Units cannot be negative'
]

{ #category : #tests }
MeasurementUnitTest >> testParsecUnitConvertsOneParsecToThreeLightYears [

	| aParsecUnit |
	aParsecUnit := ParsecUnit of: 1.
	self assert: aParsecUnit inLightYears equals: 3
]

{ #category : #tests }
MeasurementUnitTest >> testParsecUnitHasAValueInParsecs [

	| aParsecUnit |
	aParsecUnit := ParsecUnit of: 1.
	self assert: aParsecUnit inParsecs equals: 1
]

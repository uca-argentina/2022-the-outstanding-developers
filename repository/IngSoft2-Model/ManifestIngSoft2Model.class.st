"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestIngSoft2Model,
	#superclass : #PackageManifest,
	#category : #'IngSoft2-Model-Manifest'
}

{ #category : #'code-critics' }
ManifestIngSoft2Model class >> ruleCollectionProtocolRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#SpaceshipHoldingACard #effectOnThrowWith:and: #false)) #'2022-07-18T12:40:19.815-03:00') )
]

{ #category : #'code-critics' }
ManifestIngSoft2Model class >> ruleGuardingClauseRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#Board #dealCard #false)) #'2022-07-18T10:04:52.938-03:00') #(#(#RGMethodDefinition #(#Board #movePlayingSpaceshipAt:by: #false)) #'2022-07-18T10:12:39.297-03:00') #(#(#RGMethodDefinition #(#OutstandingSpaceshipsGame #refillDeckIfEmpty #false)) #'2022-07-18T11:57:38.257-03:00') )
]

{ #category : #'code-critics' }
ManifestIngSoft2Model class >> ruleReGuardClauseRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#Board #dealCard #false)) #'2022-07-18T10:04:46.784-03:00') #(#(#RGMethodDefinition #(#Board #movePlayingSpaceshipAt:by: #false)) #'2022-07-18T10:12:43.154-03:00') #(#(#RGMethodDefinition #(#OutstandingSpaceshipsGame #refillDeckIfEmpty #false)) #'2022-07-18T11:57:40.557-03:00') )
]

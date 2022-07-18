Class {
	#name : #DiceCup,
	#superclass : #Object,
	#instVars : [
		'dice'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
DiceCup class >> withAll: dice [

	^ self new initializeWithAll: dice
]

{ #category : #initialization }
DiceCup >> initializeWithAll: theDice [
 
	dice := theDice
]

{ #category : #rolling }
DiceCup >> roll [

	^ dice sum: [ :die | die roll ]
]

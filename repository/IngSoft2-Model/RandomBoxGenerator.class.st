Class {
	#name : #RandomBoxGenerator,
	#superclass : #Object,
	#instVars : [
		'randomBoxes'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
RandomBoxGenerator class >> with: aNumberOfBoxes and: aParsecSequence [
	^self new initializeWith: aNumberOfBoxes and: aParsecSequence 
]

{ #category : #accessing }
RandomBoxGenerator >> generate [
	^randomBoxes 
]

{ #category : #initialization }
RandomBoxGenerator >> initializeWith: aNumberOfBoxes and: aParsecSequence [

	| i |
	randomBoxes := OrderedCollection new.
	i := 0.
	[ i < aNumberOfBoxes ] whileTrue: [ 
		| randomNumber |
		randomNumber := (0 to: 100) atRandom.
		randomNumber < 40
			ifTrue: [ randomBoxes add: (Box withEffect: NormalBox new) ]
			ifFalse: [ 
				randomNumber < 60
					ifTrue: [ randomBoxes add: (Box withEffect: SpeedUpBox new) ]
					ifFalse: [ 
						randomNumber < 80
							ifTrue: [ randomBoxes add: (Box withEffect: WormHoleBox new) ]
							ifFalse: [ 
								randomNumber < 90
									ifTrue: [ 
										randomBoxes add:
											(Box withEffect:
												 (MoonWalkBox displacing: aNumberOfBoxes atRandom)) ]
									ifFalse: [ 
										randomNumber < 98
											ifTrue: [ 
												randomBoxes add:
													(Box withEffect: (HyperJump with: aParsecSequence)) ]
											ifFalse: [ 
											randomBoxes add: (Box withEffect: AtomicBombBox new) ] ] ] ] ].
		i := i + 1 ]
]

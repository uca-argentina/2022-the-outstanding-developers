Class {
	#name : #RandomBoxGenerator,
	#superclass : #Object,
	#instVars : [
		'randomBoxes'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
RandomBoxGenerator class >> with: aNumberOfBoxes [
	^self new initializeWith: aNumberOfBoxes 
]

{ #category : #accessing }
RandomBoxGenerator >> generate [
	^randomBoxes 
]

{ #category : #initialization }
RandomBoxGenerator >> initializeWith: aNumberOfBoxes [
	| orderedBoxes normalBox wormHoleBox speedUpBox moonWalkBox hyperJumpBox atomicBombBox |
	orderedBoxes := OrderedCollection new.
	normalBox := Box withEffect: NormalBox new.
	wormHoleBox := Box withEffect: WormHoleBox new.
	speedUpBox := Box withEffect: SpeedUpBox new.
	moonWalkBox := Box withEffect: (MoonWalkBox displacing: 1).
	hyperJumpBox := Box withEffect: (HyperJump with: { 10. 6 }).
	atomicBombBox := Box withEffect: (AtomicBombBox new).
	(aNumberOfBoxes * 0.4) floor timesRepeat: [ orderedBoxes add: normalBox].
	(aNumberOfBoxes * 0.2) floor timesRepeat: [ orderedBoxes add: wormHoleBox].
	(aNumberOfBoxes * 0.2) floor timesRepeat: [ orderedBoxes add: speedUpBox  ].
	(aNumberOfBoxes * 0.1) floor timesRepeat: [ orderedBoxes add: moonWalkBox ].
	(aNumberOfBoxes * 0.08) floor timesRepeat: [ orderedBoxes add: hyperJumpBox ].
	(aNumberOfBoxes * 0.02) floor timesRepeat: [ orderedBoxes add: atomicBombBox  ].
	(aNumberOfBoxes - orderedBoxes size) timesRepeat: [ 
			| boxesToSelect |
			boxesToSelect := { normalBox. wormHoleBox. speedUpBox. moonWalkBox. hyperJumpBox. atomicBombBox }.
			orderedBoxes add: (boxesToSelect at: boxesToSelect size atRandom)
		 ].
	randomBoxes := orderedBoxes shuffled

]

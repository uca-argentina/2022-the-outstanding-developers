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

	| orderedBoxes normalBox wormHoleBox speedUpBox hyperJumpBox atomicBombBox |
	orderedBoxes := OrderedCollection new.
	normalBox := Box withEffect: NormalBox new.
	wormHoleBox := Box withEffect: WormHoleBox new.
	speedUpBox := Box withEffect: SpeedUpBox new.
	hyperJumpBox := Box withEffect: (HyperJump with: aParsecSequence).
	atomicBombBox := Box withEffect: AtomicBombBox new.
	(aNumberOfBoxes * 0.4) floor timesRepeat: [ 
		orderedBoxes add: normalBox ].
	(aNumberOfBoxes * 0.2) floor timesRepeat: [ 
		orderedBoxes add: wormHoleBox ].
	(aNumberOfBoxes * 0.2) floor timesRepeat: [ 
		orderedBoxes add: speedUpBox ].
	(aNumberOfBoxes * 0.1) floor timesRepeat: [ 
		orderedBoxes add:
			(Box withEffect: (MoonWalkBox displacing: aNumberOfBoxes atRandom)) ].
	(aNumberOfBoxes * 0.08) floor timesRepeat: [ 
		orderedBoxes add: hyperJumpBox ].
	(aNumberOfBoxes * 0.02) floor timesRepeat: [ 
		orderedBoxes add: atomicBombBox ].
	aNumberOfBoxes - orderedBoxes size timesRepeat: [ 
		| boxesToSelect |
		boxesToSelect := { 
			                 normalBox.
			                 wormHoleBox.
			                 speedUpBox.
			                 hyperJumpBox.
			                 atomicBombBox.
			                 (Box withEffect:
				                  (MoonWalkBox displacing: aNumberOfBoxes atRandom)) }.
		orderedBoxes add: (boxesToSelect at: boxesToSelect size atRandom) ].
	randomBoxes := orderedBoxes shuffled
]

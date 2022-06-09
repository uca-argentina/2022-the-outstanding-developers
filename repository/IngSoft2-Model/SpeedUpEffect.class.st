Class {
	#name : #SpeedUpEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SpeedUpEffect class >> create [
	^self new
]

{ #category : #effects }
SpeedUpEffect >> applyEffectOn: aBoard [

	^ self effectOnPosition
]

{ #category : #effects }
SpeedUpEffect >> effectOnPosition [

	^ 4
]

{ #category : #accessing }
SpeedUpEffect >> typeOfEffect [
	^'speedup'
]

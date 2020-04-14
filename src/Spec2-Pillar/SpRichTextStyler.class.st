Class {
	#name : #SpRichTextStyler,
	#superclass : #SpTextStyler,
	#category : #'Spec2-Pillar'
}

{ #category : #parsing }
SpRichTextStyler >> parseFormatString: formatString [
	self subclassResponsibility 
]

{ #category : #tests }
SpRichTextStyler >> plaintextFor: aFormatString [
	^  self writeFormatString: (self parse: aFormatString)
]

{ #category : #'as yet unclassified' }
SpRichTextStyler >> writeFormatString: aDocument [
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
SpRichTextStyler >> writePlaintextString: aDocument [
	self subclassResponsibility 
]
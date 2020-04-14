Class {
	#name : #SpPillarTextStyler,
	#superclass : #SpRichTextStyler,
	#category : #'Spec2-Pillar'
}

{ #category : #parsing }
SpPillarTextStyler >> parseFormatString: aFormatString [
	^  PRPillarParser parse: aFormatString
]

{ #category : #'as yet unclassified' }
SpPillarTextStyler >> plaintextFor: aString [
	^  self writeFormatString: (self parse: aString)
]

{ #category : #accessing }
SpPillarTextStyler >> styles [ 
	^  SpSimpleStyleProvider new 
			itemAt: #bold put: {  (TextEmphasis bold) };
			itemAt: #italic put: {  (TextEmphasis italic) };
			itemAt: #strikeThrough put: {  (TextEmphasis struckOut) };
			itemAt: #annotatedParagraph put: {  (TextColor blue) };
			itemAt: #code put: {  (TextColor green) };
			itemAt: #anchor put: {  (TextColor blue) };
			itemAt: #preFormatted put: {  (TextColor gray) };
			itemAt: #table put: {  (TextColor yellow ) };
			itemAt: #internalLink put: {  (TextColor blue) };
			itemAt: #monospace put: { TextFontReference toFont: (LogicalFont 
				familyName: 'Source Code Pro' 
				pointSize: 10.0) };
			itemAt: #header1 put: { TextFontReference toFont: (LogicalFont 
				familyName: 'Source Sans Pro' 
				pointSize: 25.0) };
			itemAt: #header2 put: { TextFontReference toFont: (LogicalFont 
				familyName: 'Source Sans Pro' 
				pointSize: 20.0) };
			itemAt: #header3 put: { TextFontReference toFont: (LogicalFont 
				familyName: 'Source Sans Pro' 
				pointSize: 16.0) };
			yourself
]

{ #category : #'as yet unclassified' }
SpPillarTextStyler >> toPlaintext: aDocument [
	^  SpPillarTextWriter write: aDocument
]

{ #category : #'as yet unclassified' }
SpPillarTextStyler >> writeFormatString: aDocument [
	^  PRTextWriter new write: aDocument
]

{ #category : #'as yet unclassified' }
SpPillarTextStyler >> writePlaintextString: aDocument [
	^  SpPillarTextWriter write: aDocument
]
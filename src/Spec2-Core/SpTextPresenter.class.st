"
I handle basic multi-line text.
See AbstractWidgetPresenter

self example

You can also have a look at ListSelectionPresenter and ScrollSyncExample for more examples.

My main purpose is to handle source code (I have editing shortcuts support).

I provide the following variables and their accessors
- autoAccept is a boolean representing if the text is accepted on each keystroke.
- text is the text of the text zone.

I provide the following methods
- beForCode and beForText are shortcut for configuring me.
- getSelection return the interval currently selected.
- getText is a getter of the text
"
Class {
	#name : #SpTextPresenter,
	#superclass : #SpAbstractTextPresenter,
	#traits : 'SpTHaveWrappingScrollBars',
	#classTraits : 'SpTHaveWrappingScrollBars classTrait',
	#instVars : [
		'#scrollValue => SpObservableSlot',
		'#editionContextMenu => SpObservableSlot',
		'#scrollBarStyles',
		'#editable => SpObservableSlot'
	],
	#category : #'Spec2-Core-Widgets-Text'
}

{ #category : #specs }
SpTextPresenter class >> adapterName [

	^ #TextAdapter
]

{ #category : #commands }
SpTextPresenter class >> buildEditionCommandsGroupFor: presenterInstance [
	| rootCommandGroup |

	rootCommandGroup := CmCommandGroup forSpec beRoot.
	self 
		buildEditionCommandsGroupWith: presenterInstance 
		forRoot: rootCommandGroup.
	
	^ rootCommandGroup
]

{ #category : #commands }
SpTextPresenter class >> buildEditionCommandsGroupWith: presenter forRoot: aCmCommandsGroup [

	aCmCommandsGroup beDisplayedAsGroup.
	aCmCommandsGroup register: (self codeEditionCommandsGroupWith: presenter).
	aCmCommandsGroup register: (self codeAcceptCommandsGroupWith: presenter)
]

{ #category : #commands }
SpTextPresenter class >> codeAcceptCommandsGroupWith: aPresenter [

	^ (CmCommandGroup named: 'Accept commands') asSpecGroup
		description: 'Accept or cancel changes.';
		beDisplayedAsGroup;
		register: (SpAcceptChangesCommand forSpecContext: aPresenter);
		register: (SpCancelChangesCommand forSpecContext: aPresenter);
		yourself
]

{ #category : #commands }
SpTextPresenter class >> codeEditionCommandsGroupWith: aPresenter [
	| group |

	group := (CmCommandGroup named: 'Selection edition commands') asSpecGroup.
	group
		description: 'Edit code selection.';
		beDisplayedAsGroup.
	
	SpCodeEditionCommand allSubclassesDo: [ :commandClass | 
		group register: (commandClass forSpecContext: aPresenter) ].
	
	^ group
]

{ #category : #specs }
SpTextPresenter class >> title [

	^ 'Text'
]

{ #category : #api }
SpTextPresenter >> beEditable [

	self editable: true
]

{ #category : #api }
SpTextPresenter >> beNotEditable [

	self editable: false
]

{ #category : #accessing }
SpTextPresenter >> editable: aBoolean [

	editable := aBoolean
]

{ #category : #private }
SpTextPresenter >> editionCommandsGroup [

	^ SpRecursiveContextSetter 
		visit: (self class buildEditionCommandsGroupFor: self defaultCommandsContext) 
		toSetContext: self defaultCommandsContext
]

{ #category : #accessing }
SpTextPresenter >> editionContextKeyBindings [

	^ self editionCommandsGroup asKMCategory
]

{ #category : #accessing }
SpTextPresenter >> editionContextMenu [

	^ self editionCommandsGroup asMenuPresenter
]

{ #category : #testing }
SpTextPresenter >> hasEditionContextMenu [

	^ editionContextMenu
]

{ #category : #initialization }
SpTextPresenter >> initialize [ 

	super initialize.
	self initializeTHaveWrappingScrollBars.
	self flag: #REVIEW. "We really need scrollValue?"
	scrollValue := 0@0.
	self beEditable.
	self withScrollBars.
	self withEditionContextMenu.
]

{ #category : #testing }
SpTextPresenter >> isEditable [

	^ editable
]

{ #category : #initialization }
SpTextPresenter >> registerEvents [

	super registerEvents.
	self whenScrollValueChangedDo: [ :newPosition | 
		self changed: #setScrollValue: with: { newPosition } ]
]

{ #category : #api }
SpTextPresenter >> scrollValue [
	"Return the current scroll position"

	^ scrollValue
]

{ #category : #api }
SpTextPresenter >> scrollValue: aPoint [
	"Set the scroll position"

	^ scrollValue := aPoint
]

{ #category : #'api-events' }
SpTextPresenter >> whenEditableChangedDo: aBlock [

	self property: #editable whenChangedDo: aBlock
]

{ #category : #'api-events' }
SpTextPresenter >> whenScrollValueChangedDo: aBlock [
	"Set a block to perform when the scroll value changed"
	
	self property: #scrollValue whenChangedDo: aBlock
]

{ #category : #'api-events' }
SpTextPresenter >> whenSubmitDo: aBlock [
	"This method will add a 'submit' event to the widget. It will react when user presses meta+s 
	 key (this is for historical reasons) and with enter."

	self 
		bindKeyCombination: $s meta 
		toAction: [ aBlock value: self text ]
]

{ #category : #accessing }
SpTextPresenter >> withEditionContextMenu [

	editionContextMenu := true
]

{ #category : #accessing }
SpTextPresenter >> withoutEditionContextMenu [

	editionContextMenu := true
]

# Spec migration guide: From Pharo 7 Spec to Pharo 8 Spec

This guide will cover the main changes that happened in Spec between Pharo 7 and Pharo 8 and provide informations on how to migrate from the former to the latter.

## Deprecated API

* `WindowPresenter>>model(:)` is now renamed `#presenter(:)`
* `ComposablePresenter>>defaultWindowModelClass` is now `#defaultWindowPresenterClass`
* `ComposablePresenter>>instantiateModels:` is now `#instantiatePresenters:` 

## Removals

### SpecTableLayout

An important change in this version of spec is the removal of the `SpecTableLayout`. This layout was removed because it was not used, it was untested and it was conceptually duplicating `SpecLayout`. In order to replace it you can use the `SpecTableLayout` with rows and columns.

### Methods and variables

* `WindowPresenter` title variable was removed because it provided no public API to it. If you used it, please contact us with your usecase.
* `SpecLayout>>#selector(:)` was removed because it was unused and added complexity to the code.

## Selection of the binding

We refactored the way to register and use a binding. The current way to do it is to execute this code with the right binding:

```Smalltalk
	SpecBindings value: MorphicAdapterBindings during: [ mySpecPresenter openWithSpec ]
```

## Injecting a Morph in a spec

In the previous version of Spec it was possible to inject directly a morph into a spec while declaring it. This feature was removed because it breaks the layers of the Spec framework.

The right way to use a Morph that has no presenter in Spec is to create a presenter describing the widget (as we do un `ButtonMorph`) and to create an adapter to it for each graphical framework used as backend of Spec (like with the `MorphicButtonAdapter`).

## Linking a presenter to its adapter

In the previous version of Spec, to link a presenter to an adapter you needed to create a method like this one:

```Smalltalk
ButtonPresenter class >> defaultSpec
	<spec>
	
	^ #(ButtonAdapter
		adapt: #(model))
```

This is not necessary anymore. You only needs to implement the method `#adapterName`

```Smalltalk
ButtonPresenter class >> adapterName 
	^ #ButtonAdapter
```

## Dialog's toolbar

The way dialogs toolbar works changed in this new version of Spec.
	
Before the dialog bar had one or two buttons: Ok and Cancel, but they where not configurable. Now the user can add multiple buttons and configure their actions more easily.
	
So here is how the new way works:
	
If you do not override the method #initializeDialogWindow: in your dialog, two default buttons will be added: "Ok" and "Cancel". You can then configure their actions with the #okAction: and #cancelAction: selectors.
	
If you do not want those default buttons you can override #initializeDialogWindow: and use this new API:
	
```Smalltalk
aWindow 
	addButton: ''Debug''
	do: [ :presenter | self accept. presenter close ];
	addButton: ''Ignore'' 
	do: [ :presenter | presenter close ]
```

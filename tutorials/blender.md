# Objects

## Copy modifiers between objects

* Object mode
* Select Object to copy to
* Select the object to copy from
* CTRL + L (Objects -> Link/Transfer Data)
* Copy Modifiers

# Viewport

## display normals

# ?

## merge two vertices

* "M" in edit mode
* Enable auto merge vertices (top/right)

## Apply all transform

* CTRL + A

## Move cursor

* "T" to show left menu
* Select cursor until
* At view (right menu) enter the "Location"

## Reset 3d cursor

* Shift + S -> select the bottom Cursor to Selection .

## To vertex

* Enter edit mode (TAB)
* Select vertex
* Shift + S -> select the bottom Cursor to Selection .

# model


# Extrude along normals

* Edit mode
* Select
* ALT + E -> Extrude along normals	


# vertex paint

## paint exactly faces

* Go to edit mode (TAB)
* Select the faces
* Go to "vertex paint" mode directly (no tabbing)
* Select the color
* SHIFT + K


# Animation

## create animation

* Animation
* Dope sheet -> Action Editor
* Click + icon

## duplicate/copy/paste/clone animation

* Animation
* Dope sheet -> Action Editor
* Select Action
* Click Duplicate icon (it may require to play with the previous dropdown a bit)

## Add keyframe

* press I
* select what need to be keyframed

## Set easing mode

* press a or "select both keyframes"
* right click -> set easing mode

## parent to bone

* Select mesh
* Select bone
* Right click -> parent to bone

## Add bone

* Add -> Armature
* Select Armature
* Select Bone -> E -> drag bone (extrude bone)

# curves

## flat the curves

* edit mode -> a -> curves -> set spline type -> poly

# geometry nodes

## invert curve to mesh

* edit model -> a -> segments -> switch directions
* alternative: add flip faces node


## apply failed (because it a curve)

> Transform curve to mesh in order to apply constructive modifiers

* Object mode -> object -> convert -> mesh

# mesh

# cleanup

* Select > Select Non Manifold (Ctrl+Shift+Alt+m), then Select > Select Inverse

* Switch to Vertex select.
* Select all.
* Vertex> Merge Vertices> By Distance (Remove doubles).
* Select> Select all by Trait> Non Manifold (only check Vertices).
* Switch to Face select.
* Delete faces.


Go into edit mode edit mode > Vertices vertices
Press Ctrl+v d to delete duplicate vertices. Or Use this menu:

2. Clean up faces with "Limited Dissolve"

Go into Face mode face mode
Select all faces by pressing a
Run limited disolve (there is no keyboard shortcut for this). It's found under Mesh > Clean Up > Limited Dissolve

* Select interior faces
* Delete faces.

# Physics

## Bake physics into a single frame

* Select your objects, then object -> rigid body->"bake to keyframes".
* Go to your keyframe, select all objects and join them -> "ctrl-j"
* Remove all keyframe and reposition


# Bake

## Ambient occlusion

https://blender.stackexchange.com/questions/145015/how-to-bake-ambient-occlusion



# geo nodes in c

https://blog.exppad.com/article/writing-blender-geometry-node
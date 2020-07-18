# petal
DIY 100-250w integrated bottom bracket ebike motor.

Files for generating and 3d printing a mold for the stator.

The .scad file is originally from r0gueSch0lar via Thingiverse. I have simplified it.

A stator is defined by at most six parameters. It is the union of six T-shapes
(two perpendicular rectangular prisms) and a collar (the symmetric difference of two cylinders)
intersected with a large cylinder.

.stl files are generated with OpenSCAD.

The .gcode files are generated with PrusaSlicer or eiger.io.

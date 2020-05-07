#!/bin/bash
#sh- datanode
# -t threads
# -E engine

nombre=$2
typ=".png"
blender -b $1 -E CYCLES -f 10
mv /tmp/0010.png renderizados/$nombre$typ

#ej: 
# ./run.sh <archivo blend> <nombre de guardado>
# ./run.sh prueba.blend caja

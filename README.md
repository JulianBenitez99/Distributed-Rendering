# AREP - Renderizado Distribuido en al Nube
Prototipo de un clúster compuesto por un nodo Máster y nodos hijos para el proceso de renderización de animaciones e imágenes mediante el software Blender.

## Video de Renderizado

[Youtube video](https://youtu.be/REDtSK-2asg)

## Empezando

Estas instrucciones le darán una copia del proyecto en su máquina local para su desarrollo y prueba.

### Requisitos previos
#### AWS - Linux Ubuntu 18.04
Se necesitan minimo 3 máquinas en AWS. Dos de los cuales serán los nodos y uno será el máster.

El máster debe estar autorizado para conectarse a las instancias y viceversa. No es necesario que los nodos puedan conectarse entre sí.

### Instalación

Clonar el repositorio y dirigirse a la carpeta de `AREP-PROJECT`.

`git clone https://github.com/JulianBenitez99/AREP-PROJECT.git`

En cada una de las máquinas, realizar la instalación de las dependencias corriendo el script de `install_blender.sh`.

### Corriendo el proyecto

Desde el nodo máster, utilizar el script de `render-cluster.sh` como en el siguiente ejemplo:

```bash
# Modo Animación
  ./render-cluster -a -s 1 -e 10 -f /home/ubuntu/blend_file.blend
# Modo imagen
  ./render-cluster -f /home/ubuntu/blend_file.blend -x 10
```

Exiten dos modos:
#### Animación

En este modo los frames del proyecto blender se paralelizan equitativamente entre los nodos. Los parámetros son los siguientes:

 a - Activar modo animacións\
 s - Frame de inicio\
 e - Frame final\
 f - Archivo\
 x - Frame rate (Frames por segundo para la animación)

#### Imagen

En este modo un solo nodo realiza la renderización de un único frame.

f - Archivo\
x - Frame específico



## Construido con
* [Bash](https://www.gnu.org/software/bash/) - Lenguaje de comandos y shell de Unix. 
* [Python](https://www.python.org/) - Lenguaje de programación interpretado
* [Blender](https://www.blender.org/) - Software dedicado especialmente al modelado, iluminación, renderizado, animación y creación de gráficos tridimensionales.

## Autores

* **Julián Benítez Gutíerrez** - *Desarrollo* - [JulianBenitez99](https://github.com/JulianBenitez99)
* **Cristian David López Arévalo** - *Desarrollo* - [cdavidd](https://github.com/cdavidd)


## Licencia

Este proyecto está licenciado bajo la Licencia GNU - ver el archivo [LICENSE.md](LICENSE.md) para más detalles.
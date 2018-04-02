# Taller raster

## Propósito

Comprender algunos aspectos fundamentales del paradigma de rasterización.

## Tareas

Emplee coordenadas baricéntricas para:

1. Rasterizar un triángulo;
2. Implementar un algoritmo de anti-aliasing para sus aristas; y,
3. Hacer shading sobre su superficie.

Implemente la función ```triangleRaster()``` del sketch adjunto para tal efecto, requiere la librería [frames](https://github.com/VisualComputing/framesjs/releases).

## Integrantes

Máximo 3.

Complete la tabla:

| Integrante | github nick |
|------------|-------------|
|      Jesus David Monroy Garces      |     jdmonrog      |
|      Helmer Andres Avendaño Vargas      |     helmeraac        |

## Discusión
Se implementó la rasterización del triangulo con la libreria de [frames](https://github.com/VisualComputing/framesjs/releases) utilizando las coordenadas baricentricas, así mismo utilizamos de la misma referencia logramos obtener la documentación para realizar el shading(ver referencia). 

Para observar el correcto funcionamiento utilizar las siguientes teclas:
* 'D': Rasterización
* 'S': Shading

Dificultades:
* En un principio no nos funcionaba la libreria de frames en el sistema de Windows hasta que se realizó una actualización a la libreria. Por otra parte se nos dificultó identificar las coordenadas utilizadas para realizar la rasterización del triangulo

Referencias:
* https://www.scratchapixel.com/lessons/3d-basic-rendering/rasterization-practical-implementation/rasterization-stage
* https://gist.github.com/esmitt/9848516
* https://elcodigografico.wordpress.com/2014/03/29/coordenadas-baricentricas-en-triangulos/

## Entrega

* Modo de entrega: [Fork](https://help.github.com/articles/fork-a-repo/) la plantilla en las cuentas de los integrantes (de las que se tomará una al azar).
* Plazo: 1/4/18 a las 24h.

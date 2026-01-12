Feature: Pruebas llamando métodos en JAVA

  Background:
    * def GeneradorNombres = Java.type('utils.Utilidad')
    * def generadorNombres = new GeneradorNombres();

    Scenario: Generar un nombre y apellido aleatorio
      Given def nombreCompleto = generadorNombres.generarNombreCompleto()
      Then print nombreCompleto
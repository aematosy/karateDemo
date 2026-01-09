Feature: Ejemplo de variables

  Scenario: String
    * def a = "Esto es "
    * def b = "Una prueba"
    * def resultado = "Esto es Una prueba"
    * match a+b == resultado

  Scenario: Números
    * def a = 3
    * def b = 5
    * def suma = a + b
    * def resta = b - a
    * def suma_esperada = 8
    * def resta_esperada = 1
    * match suma == suma_esperada
    * match resta != resta_esperada

  Scenario: JSON
    * def a = {"valor" : 1}
    * def b = {"resultado" : 2}
    * print b.resultado
    * match a.valor == 1

  Scenario: JSON Lista
    * def array = {"clave": [1, "HOLA", 3]}
    * print array.clave[1]
    * print array.clave

    Scenario: Lista que contiene JSON
      * def array = [{"valor":3}, {"clave": 10, "array": [1,3,8]}]
      * print array[0].valor
      * def variab = array[1].array[2]
      * print variab
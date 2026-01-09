Feature: Mi primer Scenario

  @ConParametros
  Scenario: Mi primer scenario con karate
    * def Objeto = {campo: '#(urlPath)'}
    * print Objeto.campo
    Given url Objeto.campo
    When method GET
    Then status 200
    Then print response
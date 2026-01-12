Feature: Generar token

  Scenario: Generación de token
    * url baseURL
    Given path 'auth'
    And header Accept = 'application/json'
    And header Content-Type = 'application/json'
    And request auth
    When method post
    Then status 200

    And match response.token == '#string'
    * def valorToken = response.token
    * print 'Token generado:', valorToken


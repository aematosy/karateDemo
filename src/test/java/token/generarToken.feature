Feature: Generar token

  Scenario: Generación de token
    * url 'https://restful-booker.herokuapp.com/auth'
    * request
    """
    {
    "username" : "admin",
    "password" : "password123"
    }
    """
    When method POST
    Then status 200
    * def valorToken = response.token
    * print 'Valor del token generado------------->', valorToken

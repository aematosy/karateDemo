Feature: Clockify - GET /user

  Background:
    * def apiKey = karate.get('clockifyApiKey')
    * if (!apiKey || apiKey.length == 0) karate.fail('clockifyApiKey no está configurado en karate.conf.js')
    * url clockifyBaseURL
    * configure headers = { 'Content-Type': 'application/json', 'x-api-key': '#(apiKey)' }
    * configure retry = { count: 3, interval: 800 }
    * def UserSchema = read('classpath:data/clockify/user-schema.json')

  Scenario: Obtener user y workspace en clockify
    Given path 'user'
    And retry until responseStatus == 200
    When method GET
    Then status 200
    And match response == UserSchema
    * def userEmail = response.email
    * def userName = response.name

    # Validaciones
    * assert userEmail.contains('@')
    * assert userName.length() > 0
    * assert response.id.length > 0
    * assert response.activeWorkspace.length > 10
    * if (response.status == 'ACTIVE') karate.log('El usuario está activo')

    # Guardar valores de userID y workspace
    * def userId = response.id
    * def activeWorkspace = response.activeWorkspace
    * karate.log('userId:', userId)
    * karate.log('activeWorkspace:', activeWorkspace)
    * def result = { userId: '#(userId)', activeWorkspace: '#(activeWorkspace)' }

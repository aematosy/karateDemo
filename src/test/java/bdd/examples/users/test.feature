Feature: Fail with message

  Scenario: Fail with descriptive message
    Given url 'https://jsonplaceholder.typicode.com'
    And path 'users', 1
    When method get
    Then status 200
    * if (response.id == null) karate.fail('User ID should not be null')
    * if (response.name == '') karate.fail('User name should not be empty')

  Scenario: Call feature only when needed
    Given url 'https://jsonplaceholder.typicode.com'
    And path 'users', 1
    When method get
    Then status 200

    * if (responseStatus == 200) karate.call('classpath:token/generarToken.feature') && karate.log('✅ Ejecución exitosa: status 200 - GET /users/1 OK')

  Scenario: Complex conditional logic
    Given url 'https://jsonplaceholder.typicode.com'
    And path 'users', 1
    When method get
    Then status 200
    * def handleResponse =
    """
    function(resp) {
      if (resp.id > 0) {
        karate.log('Valid user ID:', resp.id);
        return true;
      } else {
        karate.log('Invalid user ID');
        return false;
      }
    }
    """
    * def isValid = handleResponse(response)
    * match isValid == true

  Scenario: Environment-specific configuration
    * def env = karate.env || 'dev'
    * def config =
    """
    {
      "prod": { "validateStrict": true },
      "staging": { "validateStrict": false },
      "dev": { "validateStrict": false }
    }
    """
    * def settings = config[env]

    Given url 'https://jsonplaceholder.typicode.com'
    And path 'users', 1
    When method get
    Then status 200
    * if (settings.validateStrict) karate.match(response.email, '#regex .+@.+')
Feature: Crear Booking - Restful Booking

  Background:
    * def env = karate.env
    * url baseURL
    * configure headers = { Accept: 'application/json', 'Content-Type': 'application/json' }
    * configure retry = { count: 4, interval: 800 }

  @regresion_crud @crear
  Scenario Outline: CREATE - Crear booking

    * def payload = read('classpath:data/requestPOST.json')
    * print 'Payload final:', payload

    Given path 'booking'
    And request payload
    When method post
    Then status 200
    And match response.booking == '#object'
    And match response.bookingid == '#number'
    * print 'Booking creado con ID:', response.bookingid

    @env=dev
    Examples:
      | read('classpath:data/restfull/dev/data-crud.csv') |

    @env=cert
    Examples:
      | read('classpath:data/restfull/cert/data-crud.csv') |
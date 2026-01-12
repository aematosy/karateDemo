Feature: Metodo PUT

  Scenario Outline: Metodo PUT Booking
    * url baseURL
    Then call read('createBookingRandom.feature')
    Then call read('classpath:token/generarToken.feature')
    Given path 'booking', idBooking
    * header Accept = 'application/json'
    * header Cookie = 'token=' + valorToken
    * json contenido_json = read('classpath:data/requestPUT.json')
    * request contenido_json
    When method PUT
    Then status 200
    * print response

    Examples:
      | nombre | apellido | checkin    | checkout   |
      | Percy  | Cordova  | 2026-06-01 | 2026-06-25 |

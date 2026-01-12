Feature: Creación de booking

  Scenario Outline: Generación de nuevo booking
    #* configure ssl = true
    * url baseURL
    Given path 'booking'
    * header Accept = 'application/json'
    * json contenido_json = read('classpath:data/requestPOST.json')
    * request contenido_json
    When method POST
    Then status 200
    * print response
    * def idBooking = response.bookingid
    * print idBooking

    Examples:
      | nombre    | apellido | precio | checkin    | checkout   |
      | Andres    | Guerrero | 1250   | 2026-01-24 | 2026-01-26 |
      | Adrian    | Matos    | 152    | 2026-01-24 | 2026-01-26 |
      | Lionel    | Messi    | 1250   | 2026-01-27 | 2026-01-29 |
      | Cristiano | Ronaldo  | 1250   | 2026-01-21 | 2026-01-30 |

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
      | nombre | apellido | precio | checkin    | checkout   |
      | Andres | Orlano   | 1250   | 2025-05-24 | 2025-05-26 |
      | Adrian | Matos    | 152    | 2025-05-24 | 2025-05-26 |
      | Luis   | Pajuelo  | 1250   | 2025-05-27 | 2025-05-29 |
      | Andre  | Ibañez   | 1250   | 2025-05-21 | 2025-05-30 |

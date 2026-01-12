Feature: Obtener bookings

  Scenario: Obtener Booking por ID
    * url baseURL
    Then call read('getBookingRandom.feature')
    Given path 'booking', randonBookingID
    * header Accept = 'application/json'
    When method GET
    Then status 200



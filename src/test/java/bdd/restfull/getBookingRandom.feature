Feature: Booking ramdon

  Scenario: Consulta de IDs de booking existentes
    * url baseURL
    Given path 'booking'
    When method GET
    Then status 200
    * print 'Response-------------->', response
    * def getRandomBookingID =
    """
    function(response){
     var randonIndex = Math.floor(Math.random() * response.length);
     return response[randonIndex].bookingid
    }
    """
    * def randonBookingID = getRandomBookingID(response)
    * print 'Random booking ID:', randonBookingID
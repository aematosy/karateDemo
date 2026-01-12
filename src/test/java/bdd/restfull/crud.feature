Feature: RESTful Booker - CRUD PRO (token callonce, factory JS build(), schemas, negativos)

  Background:
    * url baseURL
    * configure headers = { Accept: 'application/json', 'Content-Type': 'application/json' }
    * configure retry = { count: 4, interval: 800 }

    * def bookingUtil = call read('classpath:utils/bookingData.js')

  # Token (callonce al feature existente)
    * def tokenResult = callonce read('classpath:token/generarToken.feature')
    * def token = tokenResult.valorToken
    * print 'ENV:', env, 'BASEURL:', baseURL
    * print 'TOKEN:', token

  # ---------------------------------------------------------
  # Schemas
  # ---------------------------------------------------------
    * def BookingDatesSchema =
  """
  { checkin: '#string', checkout: '#string' }
  """

    * def BookingSchema =
  """
  {
    firstname: '#string',
    lastname: '#string',
    totalprice: '#number',
    depositpaid: '#boolean',
    bookingdates: '#(BookingDatesSchema)',
    additionalneeds: '##string'
  }
  """

    * def CreateBookingResponseSchema =
  """
  { bookingid: '#number', booking: '#(BookingSchema)' }
  """


  @smoke @crud
  Scenario: Creación booking + validación schema
    * def payload = bookingUtil.build()

    Given path 'booking'
    And request payload
    When method post
    Then status 200
    * print response
    And match response == CreateBookingResponseSchema
    And match response.booking == BookingSchema

    And match response.booking.firstname == payload.firstname
    And match response.booking.lastname  == payload.lastname
    And match response.booking.bookingdates.checkin == payload.bookingdates.checkin
    And match response.booking.bookingdates.checkout == payload.bookingdates.checkout

    * def bookingId = response.bookingid
    * print 'BOOKING_ID:', bookingId


  @crud
  Scenario: Consultar booking creado
    * def payload = bookingUtil.build()

    Given path 'booking'
    And request payload
    When method post
    Then status 200
    * def bookingId = response.bookingid

    Given path 'booking', bookingId
    When method get
    Then status 200
    * print response
    And match response == BookingSchema
    And match response.firstname == payload.firstname
    And match response.lastname  == payload.lastname


  @crud
  Scenario: Actualizar booking completo
    * def payload = bookingUtil.build()

    Given path 'booking'
    And request payload
    When method post
    Then status 200
    * def bookingId = response.bookingid
    * def updatePayload = bookingUtil.build({ additionalneeds: 'Late Checkout', depositpaid: false })
    Given path 'booking', bookingId
    And header Cookie = 'token=' + token
    And request updatePayload
    When method put
    Then status 200
    * print response
    And match response == BookingSchema
    And match response.firstname == updatePayload.firstname
    And match response.lastname  == updatePayload.lastname
    And match response.depositpaid == false
    And match response.additionalneeds == 'Late Checkout'


  @crud
  Scenario: Actualización parcial
    * def payload = bookingUtil.build()

    Given path 'booking'
    And request payload
    When method post
    Then status 200
    * def bookingId = response.bookingid
    * def patchPayload =
      """
      {
        lastname: '#("PATCH-" + bookingId)',
        additionalneeds: 'Dinner'
      }
      """
    Given path 'booking', bookingId
    And header Cookie = 'token=' + token
    And request patchPayload
    When method patch
    Then status 200
    * print response
    And match response == BookingSchema
    And match response.lastname == patchPayload.lastname
    And match response.additionalneeds == 'Dinner'
    And match response.firstname == payload.firstname


  @crud
  Scenario: Eliminar booking (DELETE /booking/{id}) y luego GET => 404 (con retry)
    * def payload = bookingUtil.build()

    Given path 'booking'
    And request payload
    When method post
    Then status 200
    * def bookingId = response.bookingid

    Given path 'booking', bookingId
    And header Cookie = 'token=' + token
    When method delete
    Then status 201
    * print response
    * configure retry = { count: 5, interval: 700 }
    Given path 'booking', bookingId
    And retry until responseStatus == 404
    When method get
    Then status 404


  @unhappy
  Scenario: Crear booking con JSON mal formado => 400
    * def badJson = "{ firstname: 'Bad' }"
    Given path 'booking'
    And header Content-Type = 'application/json'
    And request badJson
    When method post
    Then assert responseStatus == 400

  @unhappy
  Scenario: Actualizar sin token => 403
    * def payload = bookingUtil.build()

    Given path 'booking'
    And request payload
    When method post
    Then status 200
    * def bookingId = response.bookingid

    * def updatePayload = bookingUtil.build({ additionalneeds: 'NoAuth' })

    Given path 'booking', bookingId
    And request updatePayload
    When method put
    Then status 403
    * print response

  @unhappy
  Scenario: Consultar booking inexistente => 404
    Given path 'booking', 999999999
    When method get
    Then status 404

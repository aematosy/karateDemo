Feature: Creación de booking con data random desde Java

  Background:
    * url baseURL
    * header Accept = 'application/json'
    * def BookingData = Java.type('utils.BookingData')
    * def contenido_json_java = BookingData.build()
    * def bookingUtil = call read('classpath:utils/bookingData.js')
    * def contenido_json_js = bookingUtil.build()

  Scenario: Crear booking con data random con JAVA
    Given path 'booking'
    And request contenido_json_java
    When method POST
    Then status 200

    * def idBooking = response.bookingid
    * print 'Booking creado con ID:', idBooking
    * print 'Request enviado:', contenido_json_java

  Scenario: Crear booking random con JS
    Given path 'booking'
    And request contenido_json_js
    When method POST
    Then status 200
    * def idBooking = response.bookingid
    * print 'idBooking:', idBooking
    * print 'payload:', contenido_json_js


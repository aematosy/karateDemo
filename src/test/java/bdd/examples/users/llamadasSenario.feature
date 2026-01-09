Feature: Llamdas a Scenarios:

  Scenario: Llamada con parametros
    * def variable = "https://www.github.com"
    * def contenidoFeature = call read("miPrimerScenario.feature@ConParametros") { urlPath : '#(variable)'}
    * print contenidoFeature.response

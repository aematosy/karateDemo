Feature: Clockify - Listar Time Entries del usuario

  Background:
    * def apiKey = karate.get('clockifyApiKey')
    * if (!apiKey || apiKey.length == 0) karate.fail('clockifyApiKey no está configurado en karate.conf.js')
    * def userContext = callonce read('classpath:bdd/cloclify/clockify-user.feature')
    * def userId = userContext.result.userId
    * def workspaceId = userContext.result.activeWorkspace
    * url clockifyBaseURL
    * configure headers = { 'Content-Type': 'application/json', 'x-api-key': '#(apiKey)' }
    * configure retry = { count: 3, interval: 800 }

  Scenario: GET /workspaces/{workspaceId}/user/{userId}/time-entries
    Given path 'workspaces', workspaceId, 'user', userId, 'time-entries'
    And retry until responseStatus == 200
    When method GET
    Then status 200

    # Validaciones
    * match response == '#array'
    * karate.log('Total time entries:', response.length)
    * def TimeEntrySchema = read('classpath:data/clockify/time-entry-schema.json')
    * def validateSchema =
    """
    function(entries, schema, expectedUserId, expectedWorkspaceId) {
      if (entries.length === 0) {
        karate.log('No hay time entries para validar');
        return true;
      }

      for (var i = 0; i < entries.length; i++) {
        var entry = entries[i];

        // Validar contra schema
        try {
          karate.match(entry, schema);
        } catch (e) {
          karate.fail('Entry ' + (i+1) + ' no coincide con el schema: ' + e.message);
        }

        // Validar userId y workspaceId correctos
        if (entry.userId !== expectedUserId) {
          karate.fail('Entry ' + (i+1) + ': userId incorrecto. Esperado: ' + expectedUserId + ', Obtenido: ' + entry.userId);
        }
        if (entry.workspaceId !== expectedWorkspaceId) {
          karate.fail('Entry ' + (i+1) + ': workspaceId incorrecto. Esperado: ' + expectedWorkspaceId + ', Obtenido: ' + entry.workspaceId);
        }
      }

      karate.log('Validacion de schema completada correctamente');
      return true;
    }
    """
    * assert validateSchema(response, TimeEntrySchema, userId, workspaceId)

    * def entriesWithProjects = karate.filter(response, function(x){ return x.projectId != null })

    # Obtener un projectID aleatorio
    * def randomIndex = Math.floor(Math.random() * entriesWithProjects.length)
    * def projectId = entriesWithProjects[randomIndex].projectId
    * assert projectId != null
    * karate.log('ProjectId seleccionado aleatoriamente:', projectId)




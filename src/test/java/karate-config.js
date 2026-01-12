function fn() {

  var env = karate.env || 'dev';
  karate.log('Running Karate with env:', env);

  var config = {
    env: env,

    // URLs
    baseURL: '',
    clockifyBaseURL: '',

    // Auth (defaults)
    auth: {
      username: '',
      password: ''
    },

    // Clockify API Key
    clockifyApiKey: 'NjE3OGRlMGQtMjA5Zi00ZDUzLTk5NTctYjU1ZjhjZjlmMjU1',

    timeouts: {
      connect: 10000,
      read: 10000
    }
  };

  if (env === 'dev') {
    config.baseURL = 'https://restful-booker.herokuapp.com';
    config.auth.username = 'admin';
    config.auth.password = 'password123';
    config.clockifyBaseURL = 'https://api.clockify.me/api/v1';

  } else if (env === 'cert') {
    config.baseURL = 'https://restful-booker.herokuapp.com';
    config.auth.username = 'admin';
    config.auth.password = 'password123';
    config.clockifyBaseURL = 'https://api.clockify.me/api/v1';

  } else if (env === 'e2e') {
    // ejemplo futuro
    // config.baseURL = 'https://qa.mi-api.com';
    // config.auth.username = 'qa_user';
    // config.auth.password = 'qa_pass';
  }

  // ---------------------------------------------------------------------------
  // Configuraciones globales Karate
  // ---------------------------------------------------------------------------
  karate.configure('connectTimeout', config.timeouts.connect);
  karate.configure('readTimeout', config.timeouts.read);
  karate.configure('ssl', true);

  return config;
}

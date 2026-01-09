function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    env: env,
    myVarName: 'someValue',
    baseURL: ''
  }
  if (env == 'dev') {
    config.baseURL ='https://restful-booker.herokuapp.com'
  } else if (env == 'e2e') {
    // customize
  }
  return config;
}
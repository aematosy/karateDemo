package bdd;

import com.intuit.karate.junit5.Karate;

class UsersRunner {

    @Karate.Test
    Karate testUsers() {
        return Karate.run("classpath:bdd/cloclify/time-entries.feature")
                .karateEnv("dev")
                //.tags("@regresion_crud")
                .relativeTo(getClass());
    }
}
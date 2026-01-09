package bdd;

import com.intuit.karate.junit5.Karate;

class UsersRunner {
    
    @Karate.Test
    Karate testUsers() {
        return Karate.run("classpath:bdd/restfull/createBookingRandom.feature").relativeTo(getClass());
    }    

}

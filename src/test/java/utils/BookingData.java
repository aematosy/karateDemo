package utils;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ThreadLocalRandom;

public class BookingData {

    private static final String[] NOMBRES = {
            "Adrian", "Luis", "Andres", "Carlos", "Miguel", "Diego", "Jorge"
    };

    private static final String[] APELLIDOS = {
            "Matos", "Pajuelo", "Orlano", "Ibañez", "Gomez", "Ramos", "Torres"
    };

    public static Map<String, Object> build() {

        String nombre = NOMBRES[ThreadLocalRandom.current().nextInt(NOMBRES.length)];
        String apellido = APELLIDOS[ThreadLocalRandom.current().nextInt(APELLIDOS.length)];

        int totalPrice = ThreadLocalRandom.current().nextInt(100, 5000);

        LocalDate checkin = LocalDate.now();
        LocalDate checkout = checkin.plusDays(7);

        Map<String, Object> bookingDates = new HashMap<>();
        bookingDates.put("checkin", checkin.toString());
        bookingDates.put("checkout", checkout.toString());

        Map<String, Object> payload = new HashMap<>();
        payload.put("firstname", nombre);
        payload.put("lastname", apellido);
        payload.put("totalprice", totalPrice);
        payload.put("depositpaid", true);
        payload.put("bookingdates", bookingDates);
        payload.put("additionalneeds", "Breakfast");

        return payload;
    }
}

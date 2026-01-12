package utils;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Random;

public class Utilidad {

    private static final List<String> NOMBRES = Arrays.asList("Juan", "Miguel", "Antonio");
    private static final List<String> APELLIDOS = Arrays.asList("Franco", "Pajuelo", "Bencomo");
    private static final Random RANDOM = new Random();

    public String generarNombreCompleto() {
        String nombre = NOMBRES.get(RANDOM.nextInt(NOMBRES.size()));
        String apellido = APELLIDOS.get(RANDOM.nextInt(APELLIDOS.size()));
        return nombre +" "+ apellido;
    }
}

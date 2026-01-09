/**
 * Factory para generar datos de reservas de hotel con valores aleatorios o personalizados
 * @returns {Object} Objeto con método build para crear payloads de reserva
 */
function bookingData() {
    var LocalDate = Java.type('java.time.LocalDate');

    /**
     * Selecciona un elemento aleatorio de un array
     * @param {Array} arr - Array de elementos
     * @returns {*} Elemento aleatorio del array
     */
    function pick(arr) {
        return arr[Math.floor(Math.random() * arr.length)];
    }

    /**
     * Genera un número entero aleatorio en un rango
     * @param {number} min - Valor mínimo (inclusivo)
     * @param {number} max - Valor máximo (inclusivo)
     * @returns {number} Número aleatorio entre min y max
     */
    function randInt(min, max) {
        return Math.floor(Math.random() * (max - min + 1)) + min;
    }

    /**
     * Construye un objeto de reserva con datos aleatorios o personalizados
     * @param {Object} overrides - Propiedades a sobrescribir en el objeto base
     * @returns {Object} Payload de reserva con estructura completa
     */
    function build(overrides) {
        // Datos de prueba para nombres y apellidos
        var names = ['Enrique', 'Valentina', 'Gudalupe', 'Gerson', 'Andrea', 'Piero', 'Angelo'];
        var last = ['Matos', 'Vivas', 'Mendoza', 'Bencomo', 'Laynes', 'Cardenas', 'Uceda'];

        // Fechas de check-in (hoy) y check-out (7 días después)
        var checkin = LocalDate.now().toString();
        var checkout = LocalDate.now().plusDays(7).toString();

        // Payload base con valores aleatorios
        var payload = {
            firstname: pick(names),
            lastname: pick(last),
            totalprice: randInt(100, 5000),
            depositpaid: true,
            bookingdates: {
                checkin: checkin,
                checkout: checkout
            },
            additionalneeds: 'Breakfast'
        };

        // Inicializar overrides si es undefined
        overrides = overrides || {};

        // Manejo especial para bookingdates (merge en lugar de reemplazo completo)
        if (overrides.bookingdates) {
            payload.bookingdates.checkin = overrides.bookingdates.checkin || payload.bookingdates.checkin;
            payload.bookingdates.checkout = overrides.bookingdates.checkout || payload.bookingdates.checkout;
            delete overrides.bookingdates;
        }

        // Aplicar el resto de overrides al payload
        for (var k in overrides) {
            if (overrides.hasOwnProperty(k)) {
                payload[k] = overrides[k];
            }
        }

        return payload;
    }

    // API pública del factory
    return { build: build };
}
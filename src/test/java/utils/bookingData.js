function bookingData(){
    var LocalDate = Java.type('java.time.LocalDate');

    function pick(arr){
        return arr[Math.floor(Math.random() * arr.length) ]
    }

    function randInt (min, max){
        return Math.floor(Math.random() * (max - min + 1)) + min;
    }

    function build(overrides){
        var names = ['Adrian', 'Manuel', 'Pedro', 'Luis'];
        var last = ['Matos', 'Oliva', 'Sanchez', 'Soto']

        var checkin = LocalDate.now().toString();
        var checkout = LocalDate.now().plusDays(7).toString();

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

        overrides = overrides || {};

        if (overrides.bookingdates){
            payload.bookingdates.checkin = overrides.bookingdates.checkin || payload.bookingdates.checkin;
            payload.bookingdates.checkout = overrides.bookingdates.checkout || payload.bookingdates.checkout;
            delete overrides.bookingdates;
        }

        for (var k in overrides){
            if (overrides.hasOwnProperty(k)){
                payload[k] = overrides[k];
            }
        }

        return payload;
    }

    return {build: build};
}
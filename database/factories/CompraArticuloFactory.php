<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\ComprasArticulo;
use Faker\Generator as Faker;

$factory->define(\app\Models\ComprasArticulo::class, function (Faker $faker) {
    return [
        //
        'IdUsuario'=>$faker->randomDigitNotNull,
        'FechaHoraRegistro'=>$faker->dateTime($max = 'now', $timezone = null),
        'CodigoEstadoIngreso'=>$faker->randomElement($array = array ('I','A','F')),
        'Observaciones'=>$faker->sentence($nbWords = 20, $variableNbWords = true),
    ];
});

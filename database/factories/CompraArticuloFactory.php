<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\Models\Comprasarticulo;

use Faker\Generator as Faker;
use Illuminate\Support\Str;

$factory->define(Comprasarticulo::class, function (Faker $faker) {

    $users = App\Models\Usuario::pluck('IdUsuario')->toArray();
    return [
        //
        'IdUsuario'=>$faker->randomElement($users),
        'FechaHoraRegistro'=>$faker->dateTime($max = 'now', $timezone = null),
        'CodigoEstadoIngreso'=>$faker->randomElement($array = array ('I','A','F')),
        'Observaciones'=>$faker->sentence($nbWords = 20, $variableNbWords = true),
    ];
});

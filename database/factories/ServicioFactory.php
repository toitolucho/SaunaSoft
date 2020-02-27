<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\Models\Servicio;
use Faker\Generator as Faker;
use Illuminate\Support\Str;

$factory->define(Servicio::class, function (Faker $faker) {
    return [
        'NombreServicio'=> $faker->firstNameMale,
        'CostoServicio'		=> $faker->randomFloat($nbMaxDecimals = 2, $min = 0, $max = 10000),
        'Descripcion'		=> $faker->sentence($nbWords = 30, $variableNbWords = true),
    ];
});

<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\Models\Ventasserviciodetalle;

use Faker\Generator as Faker;
use Illuminate\Support\Str;

$factory->define(Ventasserviciodetalle::class, function (Faker $faker) {

    $ventas = App\Models\Ventasservicio::pluck('IdVentaServicio')->toArray();
    $servicios = App\Models\Servicio::pluck('IdServicio')->toArray();
    return [
        //
        'IdVentaServicio'=>$faker->randomElement($ventas),
        'IdServicio'=>$faker->randomElement($servicios),
        'Costo'=>$faker->randomFloat($nbMaxDecimals = 2, $min = 0, $max = 10000),
    ];
});

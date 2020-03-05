<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\Models\Ventasserviciodetallearticulo;

use Faker\Generator as Faker;
use Illuminate\Support\Str;

$factory->define(Ventasserviciodetallearticulo::class, function (Faker $faker) {

    $compras = App\Models\Ventasservicio::pluck('IdVentaServicio')->toArray();
    $articulos = App\Models\Articulo::pluck('IdArticulo')->toArray();
    return [
        //
        'IdVentaServicio'=>$faker->randomElement($compras),
        'IdArticulo'=>$faker->randomElement($articulos),
        'Cantidad'=>$faker->randomNumber($nbDigits = 3, $strict = false) ,
        'Costo'=>$faker->randomFloat($nbMaxDecimals = 2, $min = 0, $max = 10000),
    ];
});

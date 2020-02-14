<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\Models\Comprasarticulosdetalle;

use Faker\Generator as Faker;
use Illuminate\Support\Str;

$factory->define(Comprasarticulosdetalle::class, function (Faker $faker) {

    $compras = App\Models\Comprasarticulo::pluck('IdCompraArticulo')->toArray();
    $articulos = App\Models\Articulo::pluck('IdArticulo')->toArray();
    return [
        //
        'IdCompraArticulo'=>$faker->randomElement($compras),
        'IdArticulo'=>$faker->randomElement($articulos),
        'Cantidad'=>$faker->randomNumber($nbDigits = 3, $strict = false) ,
        'Precio'=>$faker->randomFloat($nbMaxDecimals = 2, $min = 0, $max = 10000),
    ];
});

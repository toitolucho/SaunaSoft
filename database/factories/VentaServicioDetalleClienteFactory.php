<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\Models\Cliente;
use App\Models\Ventasservicio;
use App\Models\Ventasserviciodetallecliente;

use Faker\Generator as Faker;
use Illuminate\Support\Str;

$factory->define(Ventasserviciodetallecliente::class, function (Faker $faker) {

    $ventas = App\Models\Ventasservicio::pluck('IdVentaServicio')->toArray();
    $clientes = App\Models\Cliente::pluck('IdCliente')->toArray();
    return [
        //
        'IdVentaServicio'=>$faker->randomElement($ventas),
        'IdCliente'=>$faker->randomElement($clientes),
    ];
});

<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\Models\Ventasservicio;

use App\Models\Usuario;
use App\Models\Cliente;
use App\Models\Promocion;
use Faker\Generator as Faker;
use Illuminate\Support\Str;

$factory->define(Ventasservicio::class, function (Faker $faker) {

    $usuarios = App\Models\Usuario::pluck('IdUsuario')->toArray();
    $clientes = App\Models\Cliente::pluck('IdCliente')->toArray();
    $promociones = App\Models\Promocion::pluck('IdPromocion')->toArray();
    return [
        //
        'IdUsuario'=>$faker->randomElement($usuarios),
        'IdCliente'=>$faker->randomElement($clientes),
        'FechaHoraVenta'=>$faker->dateTime($max = 'now', $timezone = null),
        'CodigoEstadoVenta'=>$faker->randomElement($array = array ('I','A','F')),
        'IdPromocion'=>$faker->randomElement($promociones),
        'NroPersonas'=> $faker->randomNumber($nbDigits = 1, $strict = false) ,
        'NroCasillero'=> $faker->numberBetween(1,30),
        'Observaciones'=>$faker->sentence($nbWords = 20, $variableNbWords = true),
    ];
});


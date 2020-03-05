<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\Models\Promocion;
use Faker\Generator as Faker;
use Illuminate\Support\Str;

$factory->define(Promocion::class, function (Faker $faker) {

    return [

        'NombrePromocion'		=> $faker->name,
        'FechaInicio'=>$faker->dateTime($max = 'now', $timezone = null),
        'FechaFin'=>$faker->dateTime($max = 'now', $timezone = null),
        'CodigoEstado'		=> $faker->randomElement($array = array ('V','C')),
        'TipoPromocion'		=> $faker->randomElement($array = array ('D','C','N','P')), //'D'->DESCUENTO, 'C'->Cumpleaños ,  'N'->N X UNO , 'P' -> DESCUENTO POR PUNTOS DE VISITA
        'PorcentajeDescuento'=> $faker->randomNumber($nbMaxDecimals = 2),
        'NroPersonas'	=> $faker->numberBetween(1,20),
        'Descripcion'		=> $faker->sentence($nbWords = 30, $variableNbWords = true),


    ];
});

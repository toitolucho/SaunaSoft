<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\Models\Usuario;
use Faker\Generator as Faker;
use Illuminate\Support\Str;

$factory->define(Usuario::class, function (Faker $faker) {
    return [
        'NombreCompleto'=> $faker->name,
        'NombreUsuario'=> $faker->userName,
        'Contrasenia'=> $faker->password,
        'FechaRegistro'=> $faker->dateTime($max = 'now', $timezone = null),
        'Direccion'=> $faker->address,
        'TipoUsuario'=> $faker->randomElement($array = array ('S','A','B')),
        'CodigoEstado'=> $faker->randomElement($array = array ('V','B','S')),

    ];
});

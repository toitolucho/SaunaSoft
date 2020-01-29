<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

/**
 * Class Usuario
 * 
 * @property int $IdUsuario
 * @property string $NombreCompleto
 * @property string $NombreUsuario
 * @property string $Contrasenia
 * @property Carbon $FechaRegistro
 * @property string $Direccion
 * @property string $TipoUsuario
 * @property string $CodigoEstado
 * 
 * @property Collection|Comprasarticulo[] $comprasarticulos
 * @property Collection|Ventasservicio[] $ventasservicios
 *
 * @package App\Models
 */
class Usuario extends Model
{
	protected $table = 'usuarios';
	protected $primaryKey = 'IdUsuario';
	public $timestamps = false;

	protected $dates = [
		'FechaRegistro'
	];

	protected $fillable = [
		'NombreCompleto',
		'NombreUsuario',
		'Contrasenia',
		'FechaRegistro',
		'Direccion',
		'TipoUsuario',
		'CodigoEstado'
	];

	public function comprasarticulos()
	{
		return $this->hasMany(Comprasarticulo::class, 'IdUsuario');
	}

	public function ventasservicios()
	{
		return $this->hasMany(Ventasservicio::class, 'IdUsuario');
	}
}

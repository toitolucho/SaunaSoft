<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

/**
 * Class Cliente
 * 
 * @property int $IdCliente
 * @property string $ci
 * @property string $Nombres
 * @property string $Apellidos
 * @property int $NroCelular
 * @property string $CorreoElectronico
 * @property Carbon $FechaNacimiento
 * @property Carbon $FechaRegistro
 * @property int $NroVisitas
 * 
 * @property Collection|Membresium[] $membresia
 * @property Collection|Promociondetallecliente[] $promociondetalleclientes
 * @property Collection|Ventasservicio[] $ventasservicios
 *
 * @package App\Models
 */
class Cliente extends Model
{
	protected $table = 'clientes';
	protected $primaryKey = 'IdCliente';
	public $timestamps = false;

	protected $casts = [
		'NroCelular' => 'int',
		'NroVisitas' => 'int'
	];

	protected $dates = [
		'FechaNacimiento',
		'FechaRegistro'
	];

	protected $fillable = [
		'ci',
		'Nombres',
		'Apellidos',
		'NroCelular',
		'CorreoElectronico',
		'FechaNacimiento',
		'FechaRegistro',
		'NroVisitas'
	];

	public function membresia()
	{
		return $this->hasMany(Membresium::class, 'IdCliente');
	}

	public function promociondetalleclientes()
	{
		return $this->hasMany(Promociondetallecliente::class, 'IdCliente');
	}

	public function ventasservicios()
	{
		return $this->belongsToMany(Ventasservicio::class, 'ventasserviciodetalleclientes', 'IdCliente', 'IdVentaServicio');
	}
}

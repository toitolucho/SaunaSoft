<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

/**
 * Class Ventasserviciodetallecliente
 * 
 * @property int $IdVentaServicio
 * @property int $IdCliente
 * 
 * @property Ventasservicio $ventasservicio
 * @property Cliente $cliente
 *
 * @package App\Models
 */
class Ventasserviciodetallecliente extends Model
{
	protected $table = 'ventasserviciodetalleclientes';
	public $incrementing = false;
	public $timestamps = false;

	protected $casts = [
		'IdVentaServicio' => 'int',
		'IdCliente' => 'int'
	];

	public function ventasservicio()
	{
		return $this->belongsTo(Ventasservicio::class, 'IdVentaServicio');
	}

	public function cliente()
	{
		return $this->belongsTo(Cliente::class, 'IdCliente');
	}
}

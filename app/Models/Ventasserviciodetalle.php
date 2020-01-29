<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

/**
 * Class Ventasserviciodetalle
 * 
 * @property int $IdVentaServicio
 * @property int $IdServicio
 * @property float $Costo
 * 
 * @property Ventasservicio $ventasservicio
 * @property Servicio $servicio
 *
 * @package App\Models
 */
class Ventasserviciodetalle extends Model
{
	protected $table = 'ventasserviciodetalle';
	public $incrementing = false;
	public $timestamps = false;

	protected $casts = [
		'IdVentaServicio' => 'int',
		'IdServicio' => 'int',
		'Costo' => 'float'
	];

	protected $fillable = [
		'Costo'
	];

	public function ventasservicio()
	{
		return $this->belongsTo(Ventasservicio::class, 'IdVentaServicio');
	}

	public function servicio()
	{
		return $this->belongsTo(Servicio::class, 'IdServicio');
	}
}

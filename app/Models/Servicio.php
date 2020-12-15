<?php

/**
 * Sauna Soft  .
 */

namespace App\Models;

use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

/**
 * Class Servicio
 *
 * @property int $IdServicio
 * @property string $NombreServicio
 * @property string $Descripcion
 * @property float $CostoServicio
 *
 * @property Collection|Ventasserviciodetalle[] $ventasserviciodetalles
 *
 * @package App\Models
 */
class Servicio extends Model
{
	protected $table = 'servicios';
	protected $primaryKey = 'IdServicio';
	public $timestamps = false;

	protected $casts = [
		'CostoServicio' => 'float'

	];

	protected $fillable = [
		'NombreServicio',
		'Descripcion',
		'CostoServicio',
        'CodigoEstado'
	];

	public function ventasserviciodetalles()
	{
		return $this->hasMany(Ventasserviciodetalle::class, 'IdServicio');
	}


}

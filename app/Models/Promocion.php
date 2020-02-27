<?php

/**
 * Sauna Soft  .
 */

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

/**
 * Class Promocione
 * 
 * @property int $IdPromocion
 * @property string $NombrePromocion
 * @property Carbon $FechaInicio
 * @property Carbon $FechaFin
 * @property string $CodigoEstado
 * @property string $TipoPromocion
 * @property float $PorcentajeDescuento
 * @property int $NroPersonas
 * @property string $Descripcion
 * 
 * @property Collection|Promociondetallecliente[] $promociondetalleclientes
 *
 * @package App\Models
 */
class Promocion extends Model
{
	protected $table = 'promociones';
	protected $primaryKey = 'IdPromocion';
	public $timestamps = false;

	protected $casts = [
		'PorcentajeDescuento' => 'float',
		'NroPersonas' => 'int'
	];

	protected $dates = [
		'FechaInicio',
		'FechaFin'
	];

	protected $fillable = [
		'NombrePromocion',
		'FechaInicio',
		'FechaFin',
		'CodigoEstado',
		'TipoPromocion',
		'PorcentajeDescuento',
		'NroPersonas',
		'Descripcion'
	];

	public function promociondetalleclientes()
	{
		return $this->hasMany(Promociondetallecliente::class, 'IdPromocion');
	}
}

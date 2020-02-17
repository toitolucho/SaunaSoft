<?php

/**
 * Sauna Soft  .
 */

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

/**
 * Class Comprasarticulo
 * 
 * @property int $IdCompraArticulo
 * @property int $IdUsuario
 * @property Carbon $FechaHoraRegistro
 * @property string $CodigoEstadoIngreso
 * @property string $Observaciones
 * 
 * @property Usuario $usuario
 * @property Collection|Comprasarticulosdetalle[] $comprasarticulosdetalles
 *
 * @package App\Models
 */
class Comprasarticulo extends Model
{
	protected $table = 'comprasarticulos';
	protected $primaryKey = 'IdCompraArticulo';
	public $timestamps = false;

	protected $casts = [
		'IdUsuario' => 'int'
	];

	protected $dates = [
		'FechaHoraRegistro'
	];

	protected $fillable = [
		'IdUsuario',
		'FechaHoraRegistro',
		'CodigoEstadoIngreso',
		'Observaciones'
	];

	public function usuario()
	{
		return $this->belongsTo(Usuario::class, 'IdUsuario');
	}

	public function comprasarticulosdetalles()
	{
		return $this->hasMany(Comprasarticulosdetalle::class, 'IdCompraArticulo');
	}

	public function articulos()
    {
        return $this->belongsToMany(Articulo::class, 'ComprasArticulosDetalle','IdCompraArticulo','IdArticulo')->withPivot('Cantidad','Precio');
    }
}

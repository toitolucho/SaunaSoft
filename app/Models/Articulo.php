<?php

/**
 * Sauna Soft  .
 */

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

/**
 * Class articulo
 * 
 * @property int $IdArticulo
 * @property string $CodigoArticulo
 * @property string $NombreArticulo
 * @property int $IdCategoria
 * @property int $CantidadExistencia
 * @property float $PrecioVigente
 * @property float $TotalValorado
 * @property string $TipoInventario
 * @property string $Descripcion
 * @property Carbon $FechaVencimiento
 * 
 * @property Categoria $categoria
 * @property Collection|Comprasarticulosdetalle[] $comprasarticulosdetalles
 * @property Collection|Ventasservicio[] $ventasservicios
 *
 * @package App\Models
 */
class Articulo extends Model
{
	protected $table = 'articulos';
	protected $primaryKey = 'IdArticulo';
	public $timestamps = false;

	protected $casts = [
		'IdCategoria' => 'int',
		'CantidadExistencia' => 'int',
		'PrecioVigente' => 'float',
		'TotalValorado' => 'float'
	];

	protected $dates = [
		'FechaVencimiento'
	];

	protected $fillable = [
		'CodigoArticulo',
		'NombreArticulo',
		'IdCategoria',
		'CantidadExistencia',
		'PrecioVigente',
		'TotalValorado',
		'TipoInventario',
		'Descripcion',
		'FechaVencimiento'
	];

	public function categoria()
	{
		return $this->belongsTo(Categoria::class, 'IdCategoria');
	}

	public function comprasarticulosdetalles()
	{
		return $this->hasMany(Comprasarticulosdetalle::class, 'IdArticulo','IdArticulo');
	}
	public function ventasarticulosdetalles()
	{
		return $this->hasMany(Ventaserviciodetallearticulo::class, 'IdArticulo');
	}

	public function ventasservicios()
	{
		return $this->belongsToMany(Ventasservicio::class, 'ventasserviciodetallearticulos', 'IdArticulo', 'IdVentaServicio')
					->withPivot('Cantidad', 'Costo');
	}

	public function compras()
    {
        return $this->belongsToMany(Comprasarticulo::class, 'ComprasArticulosDetalle', 'IdArticulo', 'IdCompraArticulo')
            ->withPivot('Cantidad', 'Precio');
    }
	
	protected static function boot()
    {
        parent::boot();

        static::deleting(function($telco) {
            $relationMethods = ['compras','ventasservicios'];

            foreach ($relationMethods as $relationMethod) {
                if ($telco->$relationMethod()->count() > 0) {
                    return false;
                }
            }
        });
    }
}

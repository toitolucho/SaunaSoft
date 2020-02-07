<?php

/**
 * Sauna Soft  .
 */

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

/**
 * Class Comprasarticulosdetalle
 * 
 * @property int $IdCompraArticulo
 * @property int $IdArticulo
 * @property int $Cantidad
 * @property float $Precio
 * 
 * @property Comprasarticulo $comprasarticulo
 * @property Articulo $articulo
 *
 * @package App\Models
 */
class Comprasarticulosdetalle extends Model
{
	protected $table = 'comprasarticulosdetalle';
	public $incrementing = false;
	public $timestamps = false;

	protected $casts = [
		'IdCompraArticulo' => 'int',
		'IdArticulo' => 'int',
		'Cantidad' => 'int',
		'Precio' => 'float'
	];

	protected $fillable = [
		'Cantidad',
		'Precio'
	];

	public function comprasarticulo()
	{
		return $this->belongsTo(Comprasarticulo::class, 'IdCompraArticulo');
	}

	public function articulo()
	{
		return $this->belongsTo(Articulo::class, 'IdArticulo');
	}
}

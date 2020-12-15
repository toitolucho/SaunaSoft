<?php

/**
 * Sauna Soft  .
 */

namespace App\Models;

use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

/**
 * Class Categoria
 *
 * @property int $IdCategoria
 * @property string $NombreCategoria
 *
 * @property Collection|Articulo[] $articulos
 *
 * @package App\Models
 */
class TipoCliente extends Model
{
	protected $table = 'TiposClientes';
	protected $primaryKey = 'IdTipoCliente';
	public $timestamps = false;

	protected $fillable = [
		'Descripcion'
	];

	public function clientes()
	{
		return $this->hasMany(Cliente::class, 'IdTipoCliente');
	}

    protected static function boot()
    {
        parent::boot();

        static::deleting(function($telco) {
            $relationMethods = ['clientes'];

            foreach ($relationMethods as $relationMethod) {
                if ($telco->$relationMethod()->count() > 0) {
                    return false;
                }
            }
        });
    }
}

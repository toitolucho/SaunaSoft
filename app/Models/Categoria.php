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
class Categoria extends Model
{
	protected $table = 'categorias';
	protected $primaryKey = 'IdCategoria';
	public $timestamps = false;

	protected $fillable = [
		'NombreCategoria'
	];

	public function articulos()
	{
		return $this->hasMany(Articulo::class, 'IdCategoria');
	}

    protected static function boot()
    {
        parent::boot();

        static::deleting(function($telco) {
            $relationMethods = ['articulos'];

            foreach ($relationMethods as $relationMethod) {
                if ($telco->$relationMethod()->count() > 0) {
                    return false;
                }
            }
        });
    }
}

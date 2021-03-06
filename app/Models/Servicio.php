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

    public function getEstadoAttribute()
    {
        $estado = "HOla";
        switch ($this->CodigoEstado)
        {
            case "A":
                $estado = "ACTIVO";
                break;
            case "I":
                $estado = "INACTIVO";
                break;
        }

        //return "{$this->Nombres} {$this->Apellidos}";
        return "{$estado}";
    }


	
	protected static function boot()
    {
        parent::boot();

        static::deleting(function($telco) {
            $relationMethods = ['ventasserviciodetalles'];

            foreach ($relationMethods as $relationMethod) {
                if ($telco->$relationMethod()->count() > 0) {
                    return false;
                }
            }
        });
    }
}

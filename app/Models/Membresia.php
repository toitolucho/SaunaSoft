<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Model;

/**
 * Class Membresium
 * 
 * @property int $IdMembresia
 * @property int $IdCliente
 * @property Carbon $FechaInicio
 * @property Carbon $FechaFin
 * @property string $CodigoEstado
 * @property float $CostoGeneral
 * 
 * @property Cliente $cliente
 *
 * @package App\Models
 */
class Membresia extends Model
{
	protected $table = 'membresia';
	protected $primaryKey = 'IdMembresia';
	public $timestamps = false;

	protected $casts = [
		'IdCliente' => 'int',
		'CostoGeneral' => 'float'
	];

	protected $dates = [
		'FechaInicio',
		'FechaFin'
	];

	protected $fillable = [
		'IdCliente',
		'FechaInicio',
		'FechaFin',
		'CodigoEstado',
		'CostoGeneral'
	];

	public function cliente()
	{
		return $this->belongsTo(Cliente::class, 'IdCliente');
	}

    public function getEstadoAttribute()
    {
        $estado = "HOla";
        switch ($this->CodigoEstado)
        {
            case "V":
                $estado = "VIGENTE";
                break;
            case "C":
                $estado = "CONCLUIDO";
                break;
        }

        //return "{$this->Nombres} {$this->Apellidos}";
        return "{$estado}";
    }
}

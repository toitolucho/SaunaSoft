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
		'NroPersonas' => 'int',
        'IdServicio'=>'int'
	];

	protected $dates = [
		'FechaInicio',
		'FechaFin',
        'FechaRegistro'
	];

	protected $fillable = [
		'NombrePromocion',
        'FechaRegistro',
		'FechaInicio',
		'FechaFin',
		'CodigoEstado',
		'TipoPromocion',
		'PorcentajeDescuento',
		'NroPersonas',
        'IdServicio',
		'Descripcion'
	];

    protected $appends = ['Estado'];


	public function promociondetalleclientes()
	{
		return $this->hasMany(Promociondetallecliente::class, 'IdPromocion');
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

    public function getTipoAttribute()
    {
        $estado = "HOla";
        switch ($this->TipoPromocion)
        {
            case "E":
                $estado = "POR EDAD";
                break;
            case "P":
                $estado = "PERIODO DE TIEMPO";
                break;
            case "F":
                $estado = "DIA FESTIVO";
                break;
            case "T":
                $estado = "TIPO DE CLIENTE";
                break;
            case "A":
                $estado = "ASISTENCIA Y FIDELIDAD";
                break;
            case "C":
                $estado = "POR CANTIDAD DE PERSONAS";
                break;
        }

        //return "{$this->Nombres} {$this->Apellidos}";
        return "{$estado}";
    }
    public function servicio()
    {
        return $this->hasMany(Servicio::class, 'IdServicio');
    }


}

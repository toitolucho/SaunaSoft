<?php

/**
 * Sauna Soft  .
 */

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

/**
 * Class Cliente
 *
 * @property int $IdCliente
 * @property string $ci
 * @property string $Nombres
 * @property string $Apellidos
 * @property int $NroCelular
 * @property string $CorreoElectronico
 * @property Carbon $FechaNacimiento
 * @property Carbon $FechaRegistro
 * @property int $NroVisitas
 *
 * @property Collection|Membresia[] $membresia
 * @property Collection|Promociondetallecliente[] $promociondetalleclientes
 * @property Collection|Ventasservicio[] $ventasservicios
 *
 * @package App\Models
 */
class Cliente extends Model
{
	protected $table = 'clientes';
	protected $primaryKey = 'IdCliente';
	public $timestamps = false;

	protected $casts = [
		'NroCelular' => 'int',
		'NroVisitas' => 'int',
        'IdTipoCliente' => 'int'
	];

	protected $dates = [
		'FechaNacimiento',
		'FechaRegistro'
	];

	protected $fillable = [
		'ci',
		'Nombres',
		'Apellidos',
		'NroCelular',
		'CorreoElectronico',
		'FechaNacimiento',
		'FechaRegistro',
		'NroVisitas',
        'IdTipoCliente',
        'Sexo'
	];



	public function membresia()
	{
		return $this->hasMany(Membresia::class, 'IdCliente');
	}

	public function promociondetalleclientes()
	{
		return $this->hasMany(Promociondetallecliente::class, 'IdCliente');
	}

	public function ventasservicios()
	{
		return $this->belongsToMany(Ventasservicio::class, 'ventasserviciodetalleclientes', 'IdCliente', 'IdVentaServicio');
	}

    public function getNombreCompletoAttribute()
    {
        return "{$this->Nombres} {$this->Apellidos}";
    }

    public function tipocliente()
    {
        return $this->belongsTo(TipoCliente::class, 'IdCliente');
    }

    public function getConMembresiaAttribute()
    {
        $estado = false;

        $tiene = Membresia::where("IdCliente" , "=" , "{$this->IdCliente}")->where('CodigoEstado', '=','V')-> whereRaw( "DATE(NOW()) between FechaInicio and FechaFin" )->count();
        if($tiene > 0)
            $estado = true;
        return $estado;
    }
	
	
	protected static function boot()
    {
        parent::boot();

        static::deleting(function($telco) {
            $relationMethods = ['ventasservicios','membresia'];

            foreach ($relationMethods as $relationMethod) {
                if ($telco->$relationMethod()->count() > 0) {
                    return false;
                }
            }
        });
    }


}

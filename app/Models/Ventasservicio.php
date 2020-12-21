<?php

/**
 * Sauna Soft  .
 */

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

/**
 * Class Ventasservicio
 *
 * @property int $IdVentaServicio
 * @property int $IdUsuario
 * @property int $IdCliente
 * @property Carbon $FechaHoraVenta
 * @property string $CodigoEstadoVenta
 * @property int $IdPromocion
 * @property int $NroPersonas
 * @property string $Observaciones
 *
 * @property Usuario $usuario
 * @property Cliente $cliente
 * @property Collection|Ventasserviciodetalle[] $ventasserviciodetalles
 * @property Collection|Articulo[] $articulos
 * @property Collection|Cliente[] $clientes
 *
 * @package App\Models
 */
class Ventasservicio extends Model
{
	protected $table = 'ventasservicio';
	protected $primaryKey = 'IdVentaServicio';
	public $timestamps = false;

	protected $casts = [
		'IdUsuario' => 'int',
		'IdCliente' => 'int',

        'MontoTotalPago'=>'float'
	];

	protected $dates = [
		'FechaHoraVenta'
	];

	protected $fillable = [
		'IdUsuario',
		'IdCliente',
		'FechaHoraVenta',
		'CodigoEstadoVenta',
        'NroCasillero',
		'Observaciones',
        'MontoTotalPago'
	];

	public function usuario()
	{
		return $this->belongsTo(Usuario::class, 'IdUsuario');
	}

	public function cliente()
	{
		return $this->belongsTo(Cliente::class, 'IdCliente');
	}

	public function ventasserviciodetalles()
	{
		return $this->hasMany(Ventasserviciodetalle::class, 'IdVentaServicio');
	}

    public function servicios()
    {
        return $this->belongsToMany(Servicio::class, 'VentasServicioDetalle', 'IdVentaServicio', 'IdServicio')
            ->withPivot( 'Costo','NroPersonas', 'PorcentajeDescuento','MontoPagado','IdPromocion');



    }

	public function articulos()
	{
		return $this->belongsToMany(Articulo::class, 'ventasserviciodetallearticulos', 'IdVentaServicio', 'IdArticulo')
        ->withPivot('Cantidad', 'Costo');
	}

	public function clientes()
	{
		return $this->belongsToMany(Cliente::class, 'ventasserviciodetalleclientes', 'IdVentaServicio', 'IdCliente');
	}
}

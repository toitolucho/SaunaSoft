<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

/**
 * Class Promociondetallecliente
 * 
 * @property int $IdPromocion
 * @property int $IdCliente
 * 
 * @property Promocione $promocione
 * @property Cliente $cliente
 *
 * @package App\Models
 */
class Promociondetallecliente extends Model
{
	protected $table = 'promociondetalleclientes';
	public $incrementing = false;
	public $timestamps = false;

	protected $casts = [
		'IdPromocion' => 'int',
		'IdCliente' => 'int'
	];

	public function promocione()
	{
		return $this->belongsTo(Promocione::class, 'IdPromocion');
	}

	public function cliente()
	{
		return $this->belongsTo(Cliente::class, 'IdCliente');
	}
}

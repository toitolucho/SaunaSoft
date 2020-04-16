<?php

namespace App\Http\Controllers;

use App\Models\Membresia;
use App\Models\Servicio;
use App\Models\Cliente;
use App\Models\Promociones;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class PromocionController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
         $promociones = DB::table('promociones')->paginate(15);
        return view('promociones.index', ['promociones' => $promociones]);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return view('promociones.create');
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $promociones = new Promociones();
        $promociones->NombrePromocion=$request->get('NombrePromocion');
        $promociones->FechaInicio=$request->get('FechaInicio');
        $promociones->FechaFin=$request->get('FechaFin');
        $promociones->CodigoEstado=$request->get('CodigoEstado');
        $promociones->TipoPromocion=$request->get('TipoPromocion');
        $promociones->PorcentajeDescuento=$request->get('PorcentajeDescuento');
        $promociones->Nombrepromociones=$request->get('Nombrepromociones');
        $promociones->NroPersonas=$request->get('NroPersonas');
        $promociones->Descripcion=$request->get('Descripcion');
        $promociones->save();

        return redirect('promociones');
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
}

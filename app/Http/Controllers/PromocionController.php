<?php

namespace App\Http\Controllers;

use App\Models\Membresia;
use App\Models\Servicio;
use App\Models\Cliente;
use App\Models\Promocion;
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

        $promociones = Promocion::paginate(15);

        return view('promocion.index', ['promociones' => $promociones]);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $servicios = Servicio::where('CodigoEstado','=','A')->get();
        return view('promocion.create', ['servicios'=>$servicios]);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $promocion = new Promocion();
        $promocion->NombrePromocion=$request->get('NombrePromocion');
        $promocion->FechaInicio=$request->get('FechaInicio');
        $promocion->FechaFin=$request->get('FechaFin');
        $promocion->CodigoEstado=$request->get('CodigoEstado');
        $promocion->TipoPromocion=$request->get('TipoPromocion');
        $promocion->PorcentajeDescuento=$request->get('PorcentajeDescuento');
        $promocion->NroPersonas=$request->get('NroPersonas');
        $promocion->IdServicio=$request->get('IdServicio');
        $promocion->Descripcion=$request->get('Descripcion');
        $promocion->save();

        return redirect('promocion');
    }

    public function buscar(Request $request)
    {

        $textoBusqueda = $request->get('NombrePromocion');

//        $categorias = DB::table('categorias')->where('NombreCategoria','like','%'.$textoBusqueda.'%') ->paginate(15);
        $promociones = Promocion::query()->where('NombreCategoria','like','%'.$textoBusqueda.'%')->paginate(15);
        if($promociones->isEmpty())
            return redirect('promocion')->with("no_encontrado","No se encontró ningún registro con los datos proporcionados");
        else
            return view('promocion.index', ['promocicones' => $promociones]);
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
        $promocion = Promocion::findOrFail($id);
        $servicios = Servicio::where('CodigoEstado','=','A')->get();
        return view('promocion.edit',[ 'promocion' => $promocion, 'servicios' => $servicios ]);
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
        $promocion = Promocion::find( $id);
        $promocion->NombrePromocion = $request->get('NombrePromocion');
        $promocion->FechaInicio = $request->get('FechaInicio');
        $promocion->FechaFin = $request->get('FechaFin');
        $promocion->CodigoEstado = $request->get('CodigoEstado');
        $promocion->TipoPromocion = $request->get('TipoPromocion');
        $promocion->PorcentajeDescuento = $request->get('PorcentajeDescuento');
        $promocion->NroPersonas = $request->get('NroPersonas');
        $promocion->Descripcion = $request->get('Descripcion');
        $promocion->IdServicio=$request->get('IdServicio');


        if($promocion->save())
        {

            return redirect()->route('promocion.index')->with("editado","La Promoción ha sido actualizada correctamente");
        }
        return redirect()->route('promocion.index')->withInput()->with("editado_error","La Promoción seleccioinada no pudo editarse, intentenlo nuevamente porfavor");
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $promocion = Promocion::find( $id);


        if($promocion->delete())
        {
            return redirect()->route('promocion.index')->with("eliminar","El elemento " . $promocion->NombrePromocion . ", ha sido eleminado correctamente");
        }
        return rredirect()->route('promocion.index')->withInput()->with("eliminar_error","La Categoría seleccioinada no pudo eliminarse, probablemente tiene registros que dependen de la misma");
        //
    }


}

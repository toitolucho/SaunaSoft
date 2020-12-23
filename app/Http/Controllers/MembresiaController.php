<?php

namespace App\Http\Controllers;

use App\Models\Cliente;
use App\Models\Membresia;
use App\Models\Promocion;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class MembresiaController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {


        $membresias = Membresia::with("Cliente")-> paginate(15);
        return view('membresia.index', ['membresias' => $membresias]);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {

        return view('membresia.create');
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //dd($request);
        //return $request->all();

        Membresia::create($request->all());
        //return back()->with("editado", "Membresia asignada al cliente correctamente");
        return redirect('membresias');
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Membresia  $membresia
     * @return \Illuminate\Http\Response
     */
    public function show(Membresia $membresia)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Membresia  $membresia
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $membresia = Membresia::findOrFail($id);
        $Cliente=Cliente::all();

        return view('membresia.edit',[ 'membresia' => $membresia,'clientes' => $Cliente]);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Membresia  $membresia
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $membresia = Membresia::find( $id);
        $membresia->IdCliente = $request->get('IdCliente');
        $membresia->FechaInicio = $request->get('FechaInicio');
        $membresia->FechaFin = $request->get('FechaFin');
        $membresia->CodigoEstado = $request->get('CodigoEstado');
        $membresia->CostoGeneral = $request->get('CostoGeneral');



        if($membresia->save())
        {
            return redirect()->route('membresias.index')->with("editado","La membresia ha sido actualizada correctamente");
        }
        return redirect()->route('membresias.index')->withInput()->with("editado_error","La Categoría seleccioinada no pudo editarse, intentenlo nuevamente porfavor");
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Membresia  $membresia
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $membresia = Membresia::find( $id);


        if($membresia->delete())
        {
            return redirect()->route('membresias.index')->with("eliminar","El elemento, ha sido eleminado correctamente");
        }
        return rredirect()->route('membresias.index')->withInput()->with("eliminar_error","La Membresia seleccioinada no pudo eliminarse, probablemente tiene registros que dependen de la misma");
    }


    public function buscar(Request $request)
    {

        $textoBusqueda = $request->get('NombreCliente');
//        $membresias = Promocion::with('cliente')->where('Nombres','like','%'.$textoBusqueda.'%')->orWhere('Apellidos','like','%'.$textoBusqueda.'%')->paginate(15);
        $membresias = Membresia::whereHas('cliente', function ($query)  use ($textoBusqueda){
            return $query->where('Nombres','like','%'.$textoBusqueda.'%')->orWhere('Apellidos','like','%'.$textoBusqueda.'%');
        })->paginate(15);

        //$servicios = DB::table('Membresia')->where('NombreServicio','like','%'.$textoBusqueda.'%')->paginate(15);
        if($membresias->isEmpty())
            return redirect('membresias')->with("no_encontrado","No se encontró ningún registro con los datos proporcionados");
        else
            return view('membresia.index', ['membresias' => $membresias]);
    }
}

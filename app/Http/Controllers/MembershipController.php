<?php

namespace App\Http\Controllers;

use App\Models\Membresia;
use App\Models\Cliente;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class MembershipController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $membresias = DB::table('membresia')->paginate(15);
        return view('membresia.index', ['membresias' => $membresias]);
    }

    // public function buscar(Request $request)
    // {
    //    // dd("holaaa");
    //    // dd($request->get('NombreCategoria'));
    //     $textoBusqueda = $request->get('NombreCategoria');

    //     $categorias = DB::table('membresia')->where('NombreCategoria','like','%'.$textoBusqueda.'%') ->paginate(15);
    //     if($categorias->isEmpty())
    //         return redirect('categorias')->with("no_encontrado","No se encontró ningún registro con los datos proporcionados");
    //     else
    //         return view('categoria.index', ['categorias' => $categorias]);
    // }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        dd("entramos");
        $Cliente=Cliente::all();
        return view('membresia.create',['clientes' => $Cliente]);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $validatedData = $request->validate([
            'IdCliente' => 'required',
        ]);

        $membresia = new Membresia();
        $membresia->IdCliente=$request->get('IdCliente');
        $membresia->FechaInicio=$request->get('FechaInicio');
        $membresia->FechaFin=$request->get('FechaFin');
        $membresia->CodigoEstado=$request->get('CodigoEstado');
        $membresia->CostoGeneral=$request->get('CostoGeneral');
        $membresia->save();

        return redirect('membresia');
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
    public function edit2($id)
    {
        $membresia = Membresia::where('IdMembresia','=',$id)->get();
        $Cliente=Cliente::all();
        return view('membresia.edit',[ 'membresias' => $membresia,'clientes' => $Cliente]);
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
        $membresia = Membresia::find( $id);
        $membresia->NombreCategoria = $request->get('NombreCategoria');

        if($membresia->save())
        {
            return redirect('membresia')->with("editado","La membresia ha sido actualizada correctamente");
        }
        return redirect('membresia')->withInput()->with("editado_error","La Categoría seleccioinada no pudo editarse, intentenlo nuevamente porfavor");
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $membresia = Membresia::find($id);


        if($membresia->delete())
        {
            return redirect('membresia')->with("eliminar","El elemento , ha sido eleminado correctamente");
        }
        return redirect('membresia')->withInput()->with("eliminar_error","La Categoría seleccioinada no pudo eliminarse, probablemente tiene registros que dependen de la misma");
    }
}

<?php

namespace App\Http\Controllers;

use App\Models\Proveedor;
use App\Models\TipoCliente;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class TipoClienteController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {

        $tipoClientes= TipoCliente::paginate(15);
        return view ('tipocliente.index', [ 'tiposclientes' => $tipoClientes]);
    }

    public function buscar(Request $request)
    {
        //dd("holaaa");
        // dd($request->get('NombreProveedor'));
        $textoBusqueda = $request->get('Descripcion');

        $tipoClientes = DB::table('Proveedores')->where('Descripcion','like','%'.$textoBusqueda.'%')->paginate(15);
        if($tipoClientes->isEmpty())
            return redirect('tiposclientes')->with("no_encontrado","No se encontró ningún registro con los datos proporcionados");
        else
            return view('tipocliente.index', ['tiposclientes' => $tipoClientes]);
    }


    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {


        return view('tipocliente.create');
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
            'Descripcion' => 'required|max:255'
        ]);



        $tipocliente = new TipoCliente();
        $tipocliente->Descripcion=$request->get('Descripcion');
        $tipocliente->save();
        return redirect("tiposclientes");
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
        $tipocliente = TipoCliente::findOrFail($id);

        return view('tipocliente.edit',[ 'tipocliente' => $tipocliente]);
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
        $tipocliente = TipoCliente::find( $id);
        $tipocliente->Descripcion=$request->get('Descripcion');


        if($tipocliente->save())
        {
            return redirect('tiposclientes')->with("editado","El Proveedor ha sido actualizado correctamente");
        }
        return redirect('tiposclientes')->with("editado_error","El Proveedor seleccioinada no pudo editarse, intentenlo nuevamente porfavor");
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //dd($id);
        $tipocliente = TipoCliente::find( $id);


        if($tipocliente->delete())
        {
            return redirect('tiposclientes')->with("eliminar","El elemento " . $tipocliente->Descripcion. ", ha sido eleminado correctamente");
        }
        return redirect('tiposclientes')->withInput()->with("eliminar_error","La Categoría seleccioinada no pudo eliminarse, probablemente tiene registros que dependen de la misma");
        //
    }
}

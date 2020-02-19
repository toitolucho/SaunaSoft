<?php

namespace App\Http\Controllers;

use App\Models\Cliente;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ClienteController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $clientes = DB::table('clientes')->paginate(15);
        return view ('cliente.index', [ 'clientes' => $clientes]);
    }

    public function buscar(Request $request)
    {
        //dd("holaaa");
        // dd($request->get('NombreCliente'));
        $textoBusqueda = $request->get('Nombrecliente');

        $clientes = DB::table('clientes')->where('Nombres','like','%'.$textoBusqueda.'%')->orWhere('Apellidos','like','%'.$textoBusqueda.'%')->paginate(15);
        if($clientes->isEmpty())
            return redirect('clientes')->with("no_encontrado","No se encontró ningún registro con los datos proporcionados");
        else
            return view('cliente.index', ['clientes' => $clientes]);
    }


    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
        return view('cliente.create');
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
            'Nombres' => 'required|max:255',
            'Apellidos' => 'required|max:255',
        ]);
       // dd($request->get('FechaNacimiento'));


        $cliente = new Cliente();

        $cliente->Nombres=$request->get('Nombres');

        $cliente->Apellidos=$request->get('Apellidos');
        $cliente->NroCelular=$request->get('NroCelular');
        $cliente->CorreoElectronico=$request->get('CorreoElectronico');

        //$cliente->FechaNacimiento=$request->get('FechaNacimiento');
        $cliente->FechaNacimiento=date("Y-m-d", strtotime($request->get("FechaNacimiento")));
        //date("Y-m-d", strtotime($request->input("date")))


        $cliente->FechaRegistro=Carbon::now();
        $cliente->NroVisitas=0;
        $cliente->save();

        return redirect('clientes');
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
        $cliente = Cliente::findOrFail($id);
        return view('cliente.edit',[ 'cliente' => $cliente]);
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
        $cliente = Cliente::find( $id);
        $cliente->Nombres = $request->get('Nombres');
        $cliente->Apellidos = $request->get('Apellidos');
        $cliente->NroCelular = $request->get('NroCelular');
        $cliente->CorreoElectronico = $request->get('CorreoElectronico');
        $cliente->FechaNacimiento  =date("Y-m-d", strtotime($request->get("FechaNacimiento")));//  $request->get('FechaNacimiento');

        if($cliente->save())
        {
            return redirect('clientes')->with("editado","La Cliente ha sido actualizada correctamente");
        }
        return redirect('clientes')->withInput()->with("editado_error","La Categoría seleccioinada no pudo editarse, intentenlo nuevamente porfavor");
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
        $cliente = Cliente::find( $id);


        if($cliente->delete())
        {
            return redirect('clientes')->with("eliminar","El elemento " . $cliente->Nombres . " " .$cliente->Apellidos. ", ha sido eleminado correctamente");
        }
        return redirect('clientes')->withInput()->with("eliminar_error","La Categoría seleccioinada no pudo eliminarse, probablemente tiene registros que dependen de la misma");
        //
    }
}
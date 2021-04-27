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
//        $clientes = DB::table('clientes')->paginate(15);
        $clientes= Cliente::paginate(15);
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
        $tiposClientes = DB::table('TiposClientes')->get();
        return view('cliente.create', [ 'tiposClientes' => $tiposClientes]);
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
        //dd($request->get('Sexo'));


        $cliente = new Cliente();

        $cliente->Nombres=$request->get('Nombres');
        $cliente->ci=$request->get('Ci');

        $cliente->Apellidos=$request->get('Apellidos');
        $cliente->NroCelular=$request->get('NroCelular');
        $cliente->CorreoElectronico=$request->get('CorreoElectronico');

        $cliente->FechaNacimiento=$request->get('FechaNacimiento');
        if($request->get('Sexo') == 'M')
            $cliente->Sexo="M";
        else
            $cliente->Sexo="F";
        $cliente->IdTipoCliente=$request->get('IdTipoCliente');

        //$cliente->FechaNacimiento=date("Y-m-d", strtotime($request->get("FechaNacimiento")));
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
		$tiposClientes = DB::table('TiposClientes')->get();

        return view('cliente.edit',[ 'cliente' => $cliente, 'tiposClientes' => $tiposClientes]);
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
		//dd($request->get('Sexo'));
        $cliente = Cliente::find( $id);
        $cliente->Nombres = $request->get('Nombres');
        $cliente->Apellidos = $request->get('Apellidos');
        $cliente->NroCelular = $request->get('NroCelular');
        $cliente->CorreoElectronico = $request->get('CorreoElectronico');
		$cliente->ci=$request->get('Ci');
        $cliente->FechaNacimiento  =date("Y-m-d", strtotime($request->get("FechaNacimiento")));//  $request->get('FechaNacimiento');
		if($request->get('Sexo') == 'M')
            $cliente->Sexo="M";
        else
            $cliente->Sexo="F";
        $cliente->IdTipoCliente=$request->get('IdTipoCliente');

		//dd($cliente->ci);	

        if($cliente->save())
        {
            return redirect('clientes')->with("editado","El/la Cliente ha sido actualizado correctamente");
        }
        return redirect('clientes')->withInput()->with("editado_error","El cliente seleccioinado no pudo editarse, intentenlo nuevamente porfavor");
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
        return redirect('clientes')->withInput()->with("eliminar_error","El cliente seleccionado no pudo eliminarse, probablemente tiene registros que dependen del mismo ya sea en una visita y uso de un servicio o una membresia");
        //
    }
}

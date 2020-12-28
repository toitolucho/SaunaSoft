<?php

namespace App\Http\Controllers;

use App\Models\Proveedor;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ProveedorController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
//        $Proveedores = DB::table('Proveedores')->paginate(15);
        $Proveedores= Proveedor::paginate(15);
        return view ('Proveedor.index', [ 'proveedores' => $Proveedores]);
    }

    public function buscar(Request $request)
    {
        //dd("holaaa");
        // dd($request->get('NombreProveedor'));
        $textoBusqueda = $request->get('NombreProveedor');

        $Proveedores = DB::table('Proveedores')->where('NombreRazonSocial','like','%'.$textoBusqueda.'%')->orWhere('NombreRepresentante','like','%'.$textoBusqueda.'%')->paginate(15);
        if($Proveedores->isEmpty())
            return redirect('proveedores')->with("no_encontrado","No se encontró ningún registro con los datos proporcionados");
        else
            return view('proveedor.index', ['proveedores' => $Proveedores]);
    }


    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {


        return view('Proveedor.create');
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
            'NombreRazonSocial' => 'required|max:255',
            'NombreRepresentante' => 'required|max:255',
        ]);
       // dd($request->get('FechaNacimiento'));


        $Proveedor = new Proveedor();

        $Proveedor->NombreRazonSocial=$request->get('NombreRazonSocial');
        $Proveedor->NombreRepresentante=$request->get('NombreRepresentante');

        $Proveedor->Direccion=$request->get('Direccion');
        $Proveedor->NroCelular=$request->get('NroCelular');



        $Proveedor->save();

        return redirect("proveedores");
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
        $Proveedor = Proveedor::findOrFail($id);

        return view('Proveedor.edit',[ 'proveedor' => $Proveedor]);
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
        $Proveedor = Proveedor::find( $id);
        $Proveedor->NombreRazonSocial = $request->get('NombreRazonSocial');
        $Proveedor->NombreRepresentante = $request->get('NombreRepresentante');
        $Proveedor->Direccion = $request->get('Direccion');
        $Proveedor->NroCelular = $request->get('NroCelular');


        if($Proveedor->save())
        {
            return redirect('proveedores')->with("editado","El Proveedor ha sido actualizado correctamente");
        }
        return redirect('proveedores')->with("editado_error","El Proveedor seleccioinada no pudo editarse, intentenlo nuevamente porfavor");
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
        $Proveedor = Proveedor::find( $id);


        if($Proveedor->delete())
        {
            return redirect('proveedores')->with("eliminar","El elemento " . $Proveedor->Nombres . " " .$Proveedor->Apellidos. ", ha sido eleminado correctamente");
        }
        return redirect('proveedores')->withInput()->with("eliminar_error","La Categoría seleccioinada no pudo eliminarse, probablemente tiene registros que dependen de la misma");
        //
    }
}

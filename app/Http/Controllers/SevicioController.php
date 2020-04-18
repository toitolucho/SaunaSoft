<?php

namespace App\Http\Controllers;

use App\Models\Membresia;
use App\Models\Servicio;
use App\Models\Cliente;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class SevicioController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
       $servicios = DB::table('servicios')->paginate(15);
        return view('servicios.index', ['servicios' => $servicios]);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return view('servicios.create');
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $servicio = new Servicio();
        $servicio->NombreServicio=$request->get('NombreServicio');
        $servicio->Descripcion=$request->get('Descripcion');
        $servicio->CostoServicio=$request->get('CostoServicio');
        $servicio->save();

        return redirect('servicios');
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
        //servicio::findOrFail()
        $servicio = Servicio::findOrFail($id);
        return view('servicios.edit',[ 'servicio' => $servicio]);
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
        $servicio = Servicio::find( $id);
        $servicio->NombreServicio = $request->get('NombreServicio');
        $servicio->Descripcion = $request->get('Descripcion');
        $servicio->CostoServicio = $request->get('CostoServicio');

        if($servicio->save())
        {
            return redirect('servicios')->with("editado","El servicio ha sido actualizada correctamente");
        }
        return redirect('servicios')->withInput()->with("editado_error","El servicio seleccioinado no pudo editarse, intentenlo nuevamente porfavor");


//        $servicio->save();
//
//        return redirect('servicios');
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
        $servicio = Servicio::find( $id);


        if($servicio->delete())
        {
            return redirect('servicios')->with("eliminar","El elemento " . $servicio->NombreServicio . ", ha sido eleminado correctamente");
        }
        return redirect('servicios')->withInput()->with("eliminar_error","La Categoría seleccioinada no pudo eliminarse, probablemente tiene registros que dependen de la misma");
        //
    }
}

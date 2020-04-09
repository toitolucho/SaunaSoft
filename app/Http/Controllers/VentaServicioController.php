<?php

namespace App\Http\Controllers;

use App\Models\Categoria;
use App\Rules\VentaServicioDetalleCantidadRule;
use App\Models\Promocion;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\Ventasservicio;
use App\Models\Articulo;
use App\Models\Ventasserviciodetalle;
use App\Models\Ventasserviciodetallearticulo;
use App\Models\Ventasserviciodetallecliente;
use App\Carbon\Carbon;
use Illuminate\Contracts\Validation\Rule;


class VentaServicioController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $ventas_servicios = Ventasservicio::with('ventasserviciodetalles', 'articulos', 'usuario', 'cliente', 'servicios') ->orderByDesc('IdVentaServicio')->paginate(15);
        return view('ventaservicio.index', ['ventas' => $ventas_servicios]);
    }




    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //

        $promociones = Promocion::all();
        return view('ventaservicio.create', [ 'promociones' => $promociones]);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {

//        $validatedData = $request->validate([
//            'NombreArticulo' => 'required|unique:Articulos|max:255',
//            'CantidadExistencia' => 'required|numeric|gt:-1',
//            'PrecioVigente' => 'required|numeric|gt:0',
//        ]);
        //dd($request->all());


        $validatedData = $request->validate([
            'IdCliente' => 'required',
           // 'CodigoEstadoVenta' => 'required|in:I,F,A',
            'NroPersonas' => 'required|numeric|gt:0',
            'NroCasillero' => 'required|numeric|gt:0',
            //'articulos' =>'required',
            'servicios' =>'required',
            'articulos*Cantidad' =>'required|numeric|gt:0',
            'articulos*Costo' =>'required|numeric|gt:0',
        ]);

        if( $request->input('IdPromocion')  && $request->input('IdPromocion') == "Seleccione...")
            $request->request->remove('IdPromocion');


        //dd($request->input('IdPromocion'));
        $venta = Ventasservicio::create($request->all());

        $productos = $request->input('productos', []);
        $cantidades = $request->input('cantidades', []);
        $precios = $request->input('precios', []);
        $codigos = $request->input('codigos', []);

        $cantidades_servicios = $request->input('cantidades_servicios', []);
        $precios_servicios = $request->input('precios_servicios', []);
        $codigos_servicios = $request->input('codigos_servicios', []);

        $codigos_clientes = $request->input('codigos_clientes', []);


        $validatedData = $request->validate([
            'servicios' => [ new VentaServicioDetalleCantidadRule],

        ]);



        if (count($codigos_servicios)<=0) {
            return redirect('ventasservicios/create')->with("validacion","No ha registrado ningun servicio");

        }

//        if($validatedData->fails())
//        {
//            dd("Error");
//        }

        $venta->IdUsuario = 1;
        $venta->FechaHoraVenta = \Carbon\Carbon::now();
        $venta->CodigoEstadoVenta = "I";
        $venta->IdCliente = $request->input('IdCliente');
        if( $request->input('IdPromocion')  && $request->input('IdPromocion') != "Seleccione...")
            $venta->IdPromocion = $request->input('IdPromocion');
        $venta->NroPersonas = $request->input('NroPersonas');
        $venta->NroCasillero = $request->input('NroCasillero');
        $venta->Observaciones = $request->input('Observaciones');

        $venta->save();
        for ($product=0; $product < count($productos); $product++) {
            if ($productos[$product] != '') {
                $venta->articulos()->attach($codigos[$product], ['Cantidad' => $cantidades[$product], 'Costo' => $precios[$product]]);

            }
        }

        for ($i_servicio=0; $i_servicio < count($codigos_servicios); $i_servicio++) {
            if ($codigos_servicios[$i_servicio] != '') {
                $venta->servicios()->attach($codigos_servicios[$i_servicio], [ 'Costo' => $precios_servicios[$i_servicio]]);

            }
        }

        for ($i_cliente=0; $i_cliente < count($codigos_clientes); $i_cliente++) {
            if ($codigos_clientes[$i_cliente] != '') {
                $venta->clientes()->attach($codigos_clientes[$i_cliente]);

            }
        }

        return redirect()->route('ventasservicios.index')->with("registrado","Venta registrada correctamente");;

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
        $venta = Ventasservicio::withCount('articulos', 'servicios', 'cliente', 'clientes')->with('articulos', 'servicios') ->findOrFail($id);
        $promociones = Promocion::all();

        $total = 0; //= $compra_articulo->comprasarticulosdetalles()->Cantidad * $compra_articulo->comprasarticulosdetalles()->Precio;
        foreach ($venta->articulos as $detalle)
        {
            $total = $total+$detalle->pivot->Cantidad * $detalle->pivot->Costo;
        }
        foreach ($venta->servicios as $detalle)
        {
            $total = $total+$detalle->pivot->Costo;
        }

        return view('ventaservicio.edit',[ 'venta' => $venta, 'total'=>$total , 'promociones'=> $promociones]);

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

        $venta = Ventasservicio::with('articulos', 'servicios','clientes')->find($id);

        if($venta->articulos())
        {
            $venta->articulos()->detach();
        }
        if($venta->servicios())
        {
            $venta->servicios()->detach();
        }

        if($venta->clientes())
        {
            $venta->clientes()->detach();
        }


        $productos = $request->input('productos', []);
        $cantidades = $request->input('cantidades', []);
        $precios = $request->input('precios', []);
        $codigos = $request->input('codigos', []);

       // $cantidades_servicio = $request->input('cantidades_servicios', []);
        $precios_servicios = $request->input('precios_servicios', []);
        $codigos_servicios = $request->input('codigos_servicios', []);

        $codigos_clientes = $request->input('codigos_clientes', []);



        $venta->IdUsuario = 1;
        $venta->IdCliente = $request->input('IdCliente');
        if( $request->input('IdPromocion')  && $request->input('IdPromocion') != "Seleccione...")
            $venta->IdPromocion = $request->input('IdPromocion');
        $venta->NroPersonas = $request->input('NroPersonas');
        $venta->NroCasillero = $request->input('NroCasillero');
        $venta->Observaciones = $request->input('Observaciones');

        $venta->update();
        $venta= $venta->fresh(['articulos','servicios','clientes']);
        $venta->setRelations([]);

        //$venta2 = Ventasservicio::with('articulos', 'servicios','clientes')->find($id);

        for ($product=0; $product < count($productos); $product++) {
            if ($productos[$product] != '') {
                $venta->articulos()->attach($codigos[$product], ['Cantidad' => $cantidades[$product], 'Costo' => $precios[$product]]);

            }
        }

        for ($i_servicio=0; $i_servicio < count($codigos_servicios); $i_servicio++) {
            if ($codigos_servicios[$i_servicio] != '') {
                $venta->servicios()->attach($codigos_servicios[$i_servicio], [ 'Costo' => $precios_servicios[$i_servicio]]);

            }
        }

        for ($i_cliente=0; $i_cliente < count($codigos_clientes); $i_cliente++) {
            if ($codigos_clientes[$i_cliente] != '') {
                $venta->clientes()->attach($codigos_clientes[$i_cliente]);

            }
        }

        //dd($codigos_articulos);
       ////$venta->save();

        return redirect()->route('ventasservicios.index')->with("editado","Venta actualizada correctamente");;
    }

    public function buscar(Request $request)
    {
        //dd("holaaa");
        // dd($request->get('NombreCategoria'));
        //$textoBusqueda = $request->get('IdCompraArticulo');

       // $compras = DB::table('ComprasArticulos')->where('IdCompraArticulo','=',$textoBusqueda)->paginate(15);

        $compras = Comprasarticulo::with('comprasarticulosdetalles', 'comprasarticulosdetalles.articulo', 'usuario')->where('IdCompraArticulo','=', $request->get('IdCompraArticulo'))->get();

       // dd($compras->Observaciones);

        if($compras->isEmpty())
           // return redirect('comprasarticulos.index')->with("no_encontrado","No se encontró ningún registro con los datos proporcionados");
            return redirect('comprasarticulos')->with("no_encontrado","No se encontró ningún registro con los datos proporcionados");

        else

            return view('compraarticulo.index', ['compras' => $compras]);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
//        //dd($id);
//        $categoria = Categoria::find( $id);
//
//
//        if($categoria->delete())
//        {
//            return redirect('categorias')->with("eliminar","El elemento " . $categoria->NombreCategoria . ", ha sido eleminado correctamente");
//        }
//        return redirect('categorias')->withInput()->with("eliminar_error","La Categoría seleccioinada no pudo eliminarse, probablemente tiene registros que dependen de la misma");
//        //
    }
}

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
        $compra = Comprasarticulo::with('comprasarticulosdetalles', 'comprasarticulosdetalles.articulo')->findOrFail($id);
//        $suma = $compra_articulo->comprasarticulosdetalles()->sum('Cantidad');
//        $suma = $compra_articulo->comprasarticulosdetalles()->sum('Precio');

        $total = 0; //= $compra_articulo->comprasarticulosdetalles()->Cantidad * $compra_articulo->comprasarticulosdetalles()->Precio;
        foreach ($compra->comprasarticulosdetalles as $detalle)
        {
            $total = $total+$detalle->Cantidad * $detalle->Precio;
        }
       // dd($total);
//        //dd($compras_articulos);
//        return view('compraarticulo.index', ['compras' => $compras_articulos]);

//        $categoria = Categoria::findOrFail($id);
       // dd($compra_articulo);
        return view('compraarticulo.edit',[ 'compra' => $compra, 'total'=>$total ]);
        //return view ('compraarticulo.edit', compact('compra','total'));
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

        $deletedRows = Comprasarticulosdetalle::where('IdCompraArticulo', $id)->delete();

        $compra = Comprasarticulo::with('comprasarticulosdetalles')->find($id);
//        $compra->comprasarticulosdetalles->each(function($detalle) {
//            $detalle->delete();
//        });
//
        if($compra->comprasarticulosdetalles())
        {
           // $compra->comprasarticulosdetalles()->detach();
            $compra->comprasarticulosdetalles()->delete();
        }

        //$categoria = Categoria::find( $id);


        $productos = $request->input('productos', []);
        $cantidades = $request->input('cantidades', []);
        $precios = $request->input('precios', []);
        $codigos = $request->input('codigos', []);


//        $compra->IdUsuario = 1;
//        $compra->FechaHoraRegistro = \Carbon\Carbon::now();
//        $compra->CodigoEstadoIngreso = "I";
        $compra->Observaciones = $request->input('Observaciones');;
        // $compra->IdCompraArticulo= $nextId;

        $compra->save();
        for ($product=0; $product < count($productos); $product++) {
            if ($productos[$product] != '') {
                //$order->products()->attach($productos[$product], ['quantity' => $cantidades[$product]]);
                $detalle = new Comprasarticulosdetalle();
                $detalle->IdArticulo = $codigos[$product];
                $detalle->Cantidad = $cantidades[$product];
                $detalle->Precio = $precios[$product] ;
                // $detalle->IdCompraArticulo = $nextId;
                $compra->comprasarticulosdetalles()->save($detalle);
            }
        }
        //  $compra->save();
        //dd($order->comprasarticulosdetalles());


        return redirect()->route('ventasservicios.index')->with("editado","Venta actualizada correctamente");;


//        $categoria->NombreCategoria = $request->get('NombreCategoria');
//
//
//        if($categoria->save())
//        {
//            return redirect('categorias')->with("editado","La Categoria ha sido actualizada correctamente");
//        }
//        return redirect('categorias')->withInput()->with("editado_error","La Categoría seleccioinada no pudo editarse, intentenlo nuevamente porfavor");
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

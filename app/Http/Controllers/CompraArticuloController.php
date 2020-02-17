<?php

namespace App\Http\Controllers;

use App\Models\Categoria;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\Comprasarticulo;
use App\Models\Articulo;
use App\Models\Comprasarticulosdetalle;
use App\Carbon\Carbon;


class CompraArticuloController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //dd("Hola");
        //$compras_articulos = DB::table('ComprasArticulos') ->paginate(15);
        $compras_articulos = Comprasarticulo::with('comprasarticulosdetalles', 'comprasarticulosdetalles.Articulo', 'usuario') ->orderByDesc('IdCompraArticulo')->paginate(15);

        //dd($compras_articulos);
        return view('compraarticulo.index', ['compras' => $compras_articulos]);
    }

    public function autocompletar()
    {
        $datas = Articulo::select("NombreArticulo")->get();
        $dataModified = array();
        foreach ($datas as $data)
        {
            $dataModified[] = $data->NombreArticulo;
        }
        dd(response()->json($dataModified));
        return response()->json($dataModified);

    }

    public function autocomplete(Request $request)

    {
      //  dd("Hola");

//        $data = Articulo::select("NombreArticulo")
//            ->where("NombreArticulo","LIKE","%{$request->input('query')}%")->get();
//        dd($data);
//
//        $datas = Customers::select("FirstName")->where("FirstName","LIKE","%{$request->input('query')}%")->get();
//        $dataModified = array();
//        foreach ($datas as $data)
//        {
//            $dataModified[] = $data->NombreArticulo;
//        }
//
//        return response()->json($dataModified);

        //return response()->json($data);

//        $datas = DB::table('Articulos')->select("NombreArticulo")->get();
//
//        dd($datas);
//        $dataModified = array();
//        foreach ($datas as $data)
//        {
//            $dataModified[] = $data->NombreArticulo;
//        }
        if ($request->has('q')) {
            $datas = Articulo::select("NombreArticulo")->where("NombreArticulo","LIKE","{$request->get('q')}")->get();
        }
        else
            $datas = DB::table('Articulos')->select("NombreArticulo")->get();



       // dd($datas);
        $dataModified = array();
        foreach ($datas as $data)
        {
            $dataModified[] = $data->NombreArticulo;
        }

       // return DB::table('Articulos')->select("NombreArticulo")->get();
        return response()->json($dataModified);

    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //

        $articulos = Articulo::all();
        return view('compraarticulo.create', compact('articulos'));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $statement = DB::select("SHOW TABLE STATUS LIKE 'ComprasArticulos'");
        $nextId = $statement[0]->Auto_increment;

        $compra = Comprasarticulo::create($request->all());

        $productos = $request->input('productos', []);
        $cantidades = $request->input('cantidades', []);
        $precios = $request->input('precios', []);
        $codigos = $request->input('codigos', []);


        $compra->IdUsuario = 1;
        $compra->FechaHoraRegistro = \Carbon\Carbon::now();
        $compra->CodigoEstadoIngreso = "I";
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


        return redirect()->route('comprasarticulos.index')->with("registrado","Compra registrada correctamente");;
        //return response()->json($compra::with('comprasarticulosdetalles'));
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
        $compra = Comprasarticulo::with('comprasarticulosdetalles', 'comprasarticulosdetalles.Articulo')->findOrFail($id);
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


        return redirect()->route('comprasarticulos.index')->with("editado","Compra actualizada correctamente");;


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

        $compras = Comprasarticulo::with('comprasarticulosdetalles', 'comprasarticulosdetalles.Articulo', 'usuario')->where('IdCompraArticulo','=', $request->get('IdCompraArticulo'))->get();

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

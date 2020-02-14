<?php

namespace App\Http\Controllers;

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
        $compras_articulos = DB::table('ComprasArticulos')->paginate(15);
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
        $compra->Observaciones = "ahora esta funcionando";
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
        //
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
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
}

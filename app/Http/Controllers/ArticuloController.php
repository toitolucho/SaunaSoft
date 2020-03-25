<?php

namespace App\Http\Controllers;

use App\Models\Articulo;
use App\Models\Categoria;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use PHPJasper\PHPJasper;


class ArticuloController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {

       // dd('viendo index');
        $articulos = Articulo::with('categoria')->paginate(15);
        return view ('articulo.index', [ 'articulos' => $articulos]);
    }

    /**z
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create(Categoria $categoria)
    {
        return view('articulo.create', [ 'categoria' => $categoria ]);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Categoria  $categoria
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request, Categoria $categoria)
    {

        $validatedData = $request->validate([
            'NombreArticulo' => 'required|unique:Articulos|max:255',
            'CantidadExistencia' => 'required|numeric|gt:-1',
            'PrecioVigente' => 'required|numeric|gt:0',
        ]);


        //dd("hola");
        $articulo = new Articulo();
        $articulo->NombreArticulo = $request->get('NombreArticulo');
        $articulo->CantidadExistencia = $request->get('CantidadExistencia');
        $articulo->PrecioVigente = $request->get('PrecioVigente');
        $articulo->Descripcion = $request->get('Descripcion');
        $articulo->IdCategoria = $categoria->IdCategoria;

        //dd($articulo);

        $articulo->save();

        return redirect('/categorias/' .$categoria->IdCategoria);
        //redirect()->back();
        //
    }

    public function buscar(Request $request)
    {
        //dd("Hola");
        $textoBusqueda = $request->get('NombreArticulo');

        $articulos = DB::table('articulos')->where('NombreArticulo','like','%'.$textoBusqueda.'%')->join('Categorias', 'Categorias.IdCategoria','articulos.IdCategoria')  ->paginate(15);
        if($articulos->isEmpty())
            return redirect('articulos')->with("no_encontrado","No se encontró ningún registro con los datos proporcionados");
        else
            return view('articulo.index', ['articulos' => $articulos]);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {


    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function reporte(Request $request)
    {
        $input = storage_path('Reportes/Inputs/hello_world.jasper');
        $output = storage_path( 'Reportes/Outputs');
        $options = ['format' => ['pdf'], 'locale' => 'en'];
        //dd($input);
        $this->PHPJasper = new PHPJasper();

        $this->PHPJasper->process(
            $input,
            $output,
            $options
        )->execute();
       // dd('reporte');


        //Funciona
        $file = storage_path('Reportes/Outputs/hello_world.pdf');
        if (file_exists($file)) {

            $headers = [
                'Content-Type' => 'application/pdf'
            ];
            return response()->download($file, 'Test File', $headers, 'inline');
        } else {
            abort(404, 'File not found!');
        }
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

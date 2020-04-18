<?php

namespace App\Http\Controllers;

use App\Models\Articulo;
use App\Models\Categoria;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use PHPJasper\PHPJasper;


class  ArticuloController extends Controller
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
       // dd("Hola");
        $textoBusqueda = $request->get('NombreArticulo');

        //$articulos = DB::table('articulos')->join('Categorias','articulos.IdCategoria', '=', 'Categorias.IdCategoria')->where('NombreArticulo','like','%'.$textoBusqueda.'%')->get()->paginate(15);
        $articulos = Articulo::with('categoria')->where('NombreArticulo','like','%'.$textoBusqueda.'%')->paginate(15);
        //dd($articulos);
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
    public function reporte($id)
    {
        //dd(base_path() . '/vendor');
        $input = storage_path('Reportes/Inputs/Articulos.jasper');
        $output = storage_path( 'Reportes/Outputs');
       // $options = ['format' => ['pdf'], 'locale' => 'en'];
        //dd($input);
        $this->PHPJasper = new PHPJasper();

//        $options = [
//            'format' => ['pdf'],
//            'locale' => 'en',
//            'params' => [],
//            'db_connection' => [
//                'driver' => 'mysql', //mysql, postgres, oracle, generic (jdbc)
//                'username' => 'root',
//                'password' => '',
//                'host' => 'localhost',
//                'database' => 'saunasoft',
//                'port' => '3306'
//            ]
//        ];



       // dd($IdCategoria);

        $jdbc_dir = base_path() . '\vendor\geekcom\phpjasper\bin\jasperstarter\jdbc';
        $options = [
            'format' => ['pdf'],
            'locale' => 'en',
            'params' => ['IdCategoria' => $id],
            'db_connection' => [
                'driver' => 'mysql',
                'host' => '127.0.0.1',
                'port' => '3306',
                'database' => 'saunasoft',
                'username' => 'root',
//                'password' => '',
                'jdbc_driver' => 'com.mysql.jdbc.Driver',
                'jdbc_url' => 'jdbc:mysql://localhost/saunasoft',
                'jdbc_dir' => $jdbc_dir
            ]
        ];

        $this->PHPJasper->process(
            $input,
            $output,
            $options
        )->execute();
        //Funciona
        $file = storage_path('Reportes/Outputs/Articulos.pdf');
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
    public function edit(Categoria $categoria, Articulo $articulo)
    {
          // dd($articulo);
//        $articulo = Articulo::findOrFail($id);
        return view('articulo.edit',[ 'articulo' => $articulo, 'categoria' => $categoria]);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $idCategoria, $idArticulo)
    {
        //dd($idArticulo . " ". $idCategoria);

        //dd($request);
        $categoria = Categoria::find($idCategoria);

        $articulo = Articulo::find( $idArticulo);
        $articulo->NombreArticulo = $request->get('NombreArticulo');
        $articulo->PrecioVigente = $request->get('PrecioVigente');
        $articulo->Descripcion = $request->get('Descripcion');

        if($articulo->save())
        {
            return redirect()->route( 'categorias.show', $categoria)->with("editado","El articulo ha sido actualizado satisfactoriamente");
        }
        return redirect()->route('categorias.show', $categoria)->withInput()->with("editado_error","El articulo seleccioinada no pudo editarse, intentenlo nuevamente porfavor");
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($idCategoria, $idArticulo)
    {
        $categoria = Categoria::find($idCategoria);

        $articulo = Articulo::find( $idArticulo);
        if($articulo->ventasservicios()->exists() || $articulo->compras()->exists()){
            return redirect()->route('categorias.show', $categoria)->withInput()->with("editado_error","El articulo seleccioinada no puede eliminarse ya que tiene dependencias");
        }

        else
        {
            return redirect()->route( 'categorias.show', $categoria)->with("editado","El articulo ha sido eliminado satisfactoriamente");
        }

    }
}

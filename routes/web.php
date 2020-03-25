<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

use App\Models\Articulo;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;

Route::get('/',"HomeController@index");

Route::get('/productos', function (Request $request) {

    if ($request->has('q')) {
        $datas = Articulo::select(array('IdArticulo', 'NombreArticulo', 'PrecioVigente'))->where("NombreArticulo","LIKE","%{$request->get('q')}%")->where("CantidadExistencia",">=",0)->get();
    }
    else
        $datas = DB::table('Articulos')->select("NombreArticulo")->where("CantidadExistencia",">",0)->get();


//    $datas = articulo::select("NombreArticulo")->get();
    $dataModified = array();
    foreach ($datas as $data)
    {
        $dataModified[] = $data->NombreArticulo;
    }
    //dd(response()->json($dataModified));
    return response()->json($datas);
});


Route::get('/buscarclientesAjax', function (Request $request) {

    //$datas = App\Models\Cliente::select(array('IdCliente','Nombres','Apellidos'))->where("Nombres","LIKE","%{$request->get('q')}%")->orwhere("Apellidos","LIKE","%{$request->get('q')}%")->get();
    $datas = App\Models\Cliente::select(array('IdCliente',DB::raw("CONCAT(Nombres,' ',Apellidos)  AS NombreCompleto"), 'NroVisitas'))->where("Nombres","LIKE","%{$request->get('q')}%")->orwhere("Apellidos","LIKE","%{$request->get('q')}%")->get();
    //dd(response()->json($datas));
    return response()->json($datas);
});

Route::get('/buscarserviciosAjax', function (Request $request) {

    $datas = App\Models\Servicio::select(array('IdServicio','NombreServicio','CostoServicio'))->where("NombreServicio","LIKE","%{$request->get('q')}%")->get();
    return response()->json($datas);
});


Route::get('/buscarproductosAjax', function (Request $request) {

    $datas = Articulo::select(array('IdArticulo', 'NombreArticulo', 'PrecioVigente'))->where("NombreArticulo","LIKE","%{$request->get('q')}%")->where("CantidadExistencia",">",0)->get();
    return response()->json($datas);
});




Route::resource('/categorias','CategoriaController');
Route::resource('/comprasarticulos','CompraArticuloController');
Route::resource('/articulos','ArticuloController');
Route::resource('/clientes','ClienteController');
Route::resource('/ventasservicios','VentaServicioController');



Route::post('/articulos/buscar',"ArticuloController@buscar");
Route::get('/articulos/reporte/{articulo}','ArticuloController@reporte')->name("articulos.reporte");

Route::post('/categorias/buscar',"CategoriaController@buscar");
Route::get('/comprasarticulos/autocomplete','CompraArticuloController@autocomplete')->name("comprasarticulos.autocomplete");
Route::get('/comprasarticulos/autocompletar','CompraArticuloController@autocompletar')->name("comprasarticulos.autocompletar");


Route::post('/comprasarticulos/buscar',"CompraArticuloController@buscar");
Route::post('/ventasservicios/buscar',"VentaServicioController@buscar");

Route::get ('/categorias/{categoria}/articulos/create','ArticuloController@create')->name("articulos.create1");
Route::post('/categorias/{categoria}/articulos','ArticuloController@store')->name("articulos.store2");


/*MBRESIA*/
Route::resource('membresia','MembershipController');
Route::post('Minsertar',"MembershipController@store");
// Route::post('Meliminar',"MembershipController@destroy");
// destroy
// Route::resource('/comprasarticulos','CompraArticuloController');
// Route::post('/categorias/buscar',"CategoriaController@buscar");

/*SERVISOS*/
Route::resource('servicios','SevicioController');
Route::post('Sinsertar',"SevicioController@store");

/*SERVISOS*/
Route::resource('promocion','PromotionsController');
Route::post('Pinsertar',"PromotionsController@store");



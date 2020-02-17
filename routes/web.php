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
        $datas = Articulo::select(array('IdArticulo', 'NombreArticulo', 'PrecioVigente'))->where("NombreArticulo","LIKE","%{$request->get('q')}%")->where("CantidadExistencia",">",0)->get();
    }
    else
        $datas = DB::table('Articulos')->select("NombreArticulo")->where("CantidadExistencia",">",0)->get();


//    $datas = Articulo::select("NombreArticulo")->get();
    $dataModified = array();
    foreach ($datas as $data)
    {
        $dataModified[] = $data->NombreArticulo;
    }
    //dd(response()->json($dataModified));
    return response()->json($datas);
});
Route::resource('/categorias','CategoriaController');
Route::resource('/comprasarticulos','CompraArticuloController');
Route::resource('/articulos','ArticuloController');
Route::post('/categorias/buscar',"CategoriaController@buscar");
Route::get('/comprasarticulos/autocomplete','CompraArticuloController@autocomplete')->name("comprasarticulos.autocomplete");
Route::get('/comprasarticulos/autocompletar','CompraArticuloController@autocompletar')->name("comprasarticulos.autocompletar");
Route::post('/comprasarticulos/buscar',"CompraArticuloController@buscar");



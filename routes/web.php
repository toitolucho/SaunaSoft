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

Route::get('/buscarproveedoresAjax', function (Request $request) {
    $datas = App\Models\Proveedor::select(array('IdProveedor', 'NombreRazonSocial'))->where("NombreRazonSocial","LIKE","%{$request->get('q')}%")->orwhere("NombreRepresentante","LIKE","%{$request->get('q')}%")->get();

    return response()->json($datas);
});

Route::get('/buscarserviciosAjax', function (Request $request) {

    $datas = App\Models\Servicio::select(array('IdServicio','NombreServicio','CostoServicio'))->where("NombreServicio","LIKE","%{$request->get('q')}%")->get();
    return response()->json($datas);
});


Route::get('/buscarproductosAjax', function (Request $request) {

    $datas = Articulo::select(array('IdArticulo', 'NombreArticulo', 'PrecioVigente','CantidadExistencia'))->where("NombreArticulo","LIKE","%{$request->get('q')}%")->where("CantidadExistencia",">",0)->get();
    return response()->json($datas);
});




Route::resource('/categorias','CategoriaController');
Route::resource('/comprasarticulos','CompraArticuloController');
Route::resource('/articulos','ArticuloController');
Route::resource('/clientes','ClienteController');
Route::resource('/ventasservicios','VentaServicioController');
Route::resource('/membresias','MembresiaController');
Route::resource('/promociones','PromocionController');
Route::resource('/proveedores','ProveedorController');
Route::resource('/tiposclientes','TipoClienteController');



Route::post('/articulos/buscar',"ArticuloController@buscar");
Route::post('/proveedor/buscar',"ProveedorController@buscar")->name("proveedor.buscar");
Route::post('/promociones/buscar',"PromocionController@buscar")->name("promociones.buscar");
Route::post('/servicios/buscar',"SevicioController@buscar")->name("servicio.buscar");
Route::post('/membresias/buscar',"MembresiaController@buscar")->name("membresia.buscar");
Route::post('/clientes/buscar',"ClienteController@buscar")->name("cliente.buscar");
Route::post('/tiposclientes/buscar',"TipoClienteController@buscar")->name("tipocliente.buscar");
Route::get('/articulos/reporte/{articulo}','ArticuloController@reporte')->name("articulos.reporte");
Route::delete('/articulos/destroy3/{articulo}',"ArticuloController@destroy3")->name("articulos.destroy3");



Route::post('/categorias/buscar',"CategoriaController@buscar");
Route::get('/comprasarticulos/autocomplete','CompraArticuloController@autocomplete')->name("comprasarticulos.autocomplete");
Route::get('/comprasarticulos/autocompletar','CompraArticuloController@autocompletar')->name("comprasarticulos.autocompletar");


Route::post('/comprasarticulos/buscar',"CompraArticuloController@buscar");
Route::post('/ventasservicios/buscar',"VentaServicioController@buscar");
Route::post('/ventasservicios/reporteFechas',"VentaServicioController@reporteFechas")->name("ventasservicios.reporteFechas");


Route::get ('/categorias/{categoria}/articulos/create','ArticuloController@create')->name("articulos.create1");
Route::post('/categorias/{categoria}/articulos','ArticuloController@store')->name("articulos.store2");
Route::get('/categorias/{categoria}/articulos/{articulo}/edit','ArticuloController@edit')->name("articulos.edit2");
//Route::get('/categorias/{categoria}/articulos/edit','ArticuloController@edit')->name("articulos.edit22");
Route::post('/categorias/{categoria}/articulos/{articulo}','ArticuloController@update')->name("articulos.update2");
Route::delete('/categorias/{categoria}/articulos/{articulo}','ArticuloController@destroy')->name("articulos.destroy2");


/*MBRESIA*/
//Route::resource('membresia','MembershipController');
//Route::post('Minsertar',"MembershipController@store");
// Route::post('Meliminar',"MembershipController@destroy");
// destroy
// Route::resource('/comprasarticulos','CompraArticuloController');
// Route::post('/categorias/buscar',"CategoriaController@buscar");

/*SERVISOS*/
Route::resource('servicios','SevicioController');
Route::post('Sinsertar',"SevicioController@store");

/*SERVISOS*/
//Route::resource('promocion','PromotionsController');
//Route::post('Pinsertar',"PromotionsController@store");


Route::get('/comprasarticulos/reporte/{idcompraarticulo}','CompraArticuloController@reporte')->name("comprasarticulos.reporte");
Route::get('/ventasservicios/reporte/{idventaservicio}','VentaServicioController@reporte')->name("ventasservicios.reporte");
Route::get('/ventasservicios/resumenFechas/{idventaservicio}','VentaServicioController@resumenFechas')->name("ventasservicios.resumenFechas");
Route::put('/ventasservicios/f/{ventaservicio}',"VentaServicioController@finalizar")->name('ventaservicios.finalizar');

Route::get('/reportes/inventariodiario/','ReporteController@inventariodiario')->name("reportes.inventariodiario");
Route::get('/reportes/inventariodiarioiniciofecha/{fecha}','ReporteController@inventarioinicioenfecha')->name("reportes.inventarioinicioenfecha");
Route::get('/reportes/inventariodiariocierrefecha/{fecha}','ReporteController@inventariocierreenfecha')->name("reportes.inventariocierreenfecha");

Auth::routes();

Route::get('/home', 'HomeController@index')->name('home');

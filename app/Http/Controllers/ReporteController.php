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
use PHPJasper\PHPJasper;


class ReporteController extends Controller
{
    private function generaReporte($reportName, $parametros=[])
    {
        $input = storage_path('Reportes/ventas/'.$reportName. '.jasper');
        $output = storage_path( 'Reportes/ventas');

        $hostname = env("DB_HOST", "localhost");
        $username = env("DB_USERNAME", "root");
        $database = env("DB_DATABASE", "saunasoft");
        $password = env("DB_PASSWORD", "carskeep10000");


        $this->PHPJasper = new PHPJasper();
        $jdbc_dir = base_path() . '\vendor\geekcom\phpjasper\bin\jasperstarter\jdbc';

        if($parametros)
        {
            $options = [
                'format' => ['pdf'],
                'locale' => 'en',
                'params' => $parametros,
                'db_connection' => [
                    'driver' => 'mysql',
                    'host' => $hostname,
                    'port' => '3306',
                    'database' => $database,
                    'username' => $username,
//                'password' => '',
                    'jdbc_driver' => 'com.mysql.jdbc.Driver',
                    'jdbc_url' => 'jdbc:mysql://localhost/saunasoft',
                    'jdbc_dir' => $jdbc_dir
                ]
            ];
        }
        else
        {
            $options = [
                'format' => ['pdf'],
                'locale' => 'en',
                'db_connection' => [
                    'driver' => 'mysql',
                    'host' => $hostname,
                    'port' => '3306',
                    'database' => $database,
                    'username' => $username,
//                'password' => '',
                    'jdbc_driver' => 'com.mysql.jdbc.Driver',
                    'jdbc_url' => 'jdbc:mysql://localhost/saunasoft',
                    'jdbc_dir' => $jdbc_dir
                ]
            ];
        }




//        $salidaPrueba = $this->PHPJasper->process(
//            $input,
//            $output,
//            $options
//        )->output();
//        dd($salidaPrueba);

        $this->PHPJasper->process(
            $input,
            $output,
            $options
        )->execute();
    }

    private function visualizarReporte($file)
    {
        if (file_exists($file)) {

            $headers = [
                'Content-Type' => 'application/pdf'
            ];
            return response()->download($file, 'Test File', $headers, 'inline');
        } else {
            abort(404, 'File not found!');
        }
    }

    public function inventariodiario()
    {

        $reporte = "ReporteExistenciaFinalDiaria";
        $this->generaReporte( $reporte );
        //Funciona
        $file = storage_path('Reportes/ventas/'.$reporte.'.pdf');
        return $this->visualizarReporte($file) ;
    }

    public function inventarioinicioenfecha($fecha)
    {

        //Sat Jan 09 2021 05:59:09 GMT-0400 (Bolivia Time)
        $fecha = date("Y-m-d H:i:s", $fecha);
      // dd($fecha);


        $reporte = "InventarioDiarioAperturaFecha";
        $parametros = ['FechaConsulta' =>$fecha];

        $this->generaReporte( $reporte, $parametros );


        //Funciona
        $file = storage_path('Reportes/ventas/'.$reporte.'.pdf');
        return $this->visualizarReporte($file) ;
    }

    public function inventariocierreenfecha($fecha)
    {
        $fecha = date("Y-m-d H:i:s", $fecha);
        // dd($fecha);


        $reporte = "InventarioDiarioCierreFecha";
        $parametros = ['FechaConsulta' =>$fecha];

        $this->generaReporte( $reporte, $parametros );


        //Funciona
        $file = storage_path('Reportes/ventas/'.$reporte.'.pdf');
        return $this->visualizarReporte($file) ;
    }


}

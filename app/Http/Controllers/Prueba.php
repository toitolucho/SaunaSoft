<?php

namespace App\Http\Controllers;

use PHPJasper\PHPJasper;




    public function imprimir()
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


        $jdbc_dir = base_path() . '\vendor\geekcom\phpjasper\bin\jasperstarter\jdbc';
        $options = [
            'format' => ['pdf'],
            'locale' => 'en',
            'params' => [],
            'db_connection' => [
                'driver' => 'mysql',
                'host' => '127.0.0.1',
                'port' => '3306',
                'database' => 'saunasoft',
                'username' => 'root',
                'password' => '',
                'jdbc_driver' => 'com.mysql.jdbc.Driver',
                'jdbc_url' => 'jdbc:mysql://localhost/saunasoft',
                'jdbc_dir' => $jdbc_dir
            ]
        ];

        $this->PHPJasper->process(
            $input,
            $output,
            $options
        )->output();


//        $this->PHPJasper->process(
//            $input,
//            $output,
//            $options
//        )->execute();
        // dd($options);


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

    


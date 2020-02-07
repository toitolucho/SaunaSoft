<?php

namespace App\Http\Controllers;

use App\Models\Categoria;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class CategoriaController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
		//return Categoria::();
        //$categorias = Categoria::paginate(15);
       // $categorias = DB::table('categorias')->paginate(15);

        $categorias = DB::table('categorias')->paginate(15);
        return view('categoria.index', ['categorias' => $categorias]);
    }

    public function buscar(Request $request)
    {
       // dd("holaaa");
       // dd($request->get('NombreCategoria'));
        $textoBusqueda = $request->get('NombreCategoria');

        $categorias = DB::table('categorias')->where('NombreCategoria','like','%'.$textoBusqueda.'%') ->paginate(15);
        if($categorias->isEmpty())
            return redirect('categorias')->with("no_encontrado","No se encontró ningún registro con los datos proporcionados");
        else
            return view('categoria.index', ['categorias' => $categorias]);
    }


    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
        return view('categoria.create');
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {

        $validatedData = $request->validate([
            'NombreCategoria' => 'required|unique:categorias|max:255',
        ]);

        $categoria = new Categoria();
        $categoria->NombreCategoria=$request->get('NombreCategoria');
        $categoria->save();

        return redirect('categorias');
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
        //Categoria::findOrFail()
        $categoria = Categoria::findOrFail($id);
        return view('categoria.edit',[ 'categoria' => $categoria]);
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
        $categoria = Categoria::find( $id);
        $categoria->NombreCategoria = $request->get('NombreCategoria');

        if($categoria->save())
        {
            return redirect('categorias')->with("editado","La Categoria ha sido actualizada correctamente");
        }
        return redirect('categorias')->withInput()->with("editado_error","La Categoría seleccioinada no pudo editarse, intentenlo nuevamente porfavor");


//        $categoria->save();
//
//        return redirect('categorias');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //dd($id);
        $categoria = Categoria::find( $id);


        if($categoria->delete())
        {
            return redirect('categorias')->with("eliminar","El elemento " . $categoria->NombreCategoria . ", ha sido eleminado correctamente");
        }
        return redirect('categorias')->withInput()->with("eliminar_error","La Categoría seleccioinada no pudo eliminarse, probablemente tiene registros que dependen de la misma");
        //
    }
}

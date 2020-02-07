@extends('layouts.base')
@section('content')

                <div class = "row">
					<div class = "col">
						<h1>Modificar Categoria {{$categoria->IdCategoria}}</h1>
                    </div>
				</div>
                <div class = "row">
					<div class = "col">
						<a class="btn btn-secondary" href="/categorias"> volver a Categorias </a>
                    </div>
				</div>
                <div class = "row">
					<div class = "col">
						<form action="/categorias/{{$categoria->IdCategoria}}" method="POST">
                            @csrf
                            @method('put')
                            <div class="form-group">
                                <label for="NombreCategoria"> Nombre Categoria : </label>
                                <input type="text" class="form-control" id = "NombreCategoria" name="NombreCategoria" placeholder="Ingrese el nombre del articulo" value ="{{$categoria->NombreCategoria}}">  </input>
                            </div>
                            <button class="btn btn-primary" type="submit"> Guardar</button>
                        </form>  
					</div>
				</div>
            </div>

@endsection

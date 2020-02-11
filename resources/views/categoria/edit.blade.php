@extends('welcome')
@section('content')


    <div class="container">
        <div class="card">

            <div class="card-header"><i class="fa fa-fw fa-plus-circle">
                </i> <strong>Modificar Categoria {{$categoria->IdCategoria}}</strong>
                <a href="/categorias" class="float-right btn btn-dark btn-sm"><i class="fa fa-fw fa-globe"></i> Listado de Categorias</a>
            </div>




                <div class = "row m-lg-2">
					<div class = "col">
						<form action="/categorias/{{$categoria->IdCategoria}}" method="POST">
                            @csrf
                            @method('put')
                            <div class="form-group">
                                <label for="NombreCategoria"> Nombre Categoria : </label>
                                <input type="text" class="form-control" id = "NombreCategoria" name="NombreCategoria" placeholder="Ingrese el nombre del articulo" value ="{{$categoria->NombreCategoria}}">  </input>
                            </div>
                            <button class="btn btn-primary" type="submit"> <i class="fa fa-fw far fa-save"></i> Guardar</button>

                        </form>
					</div>
				</div>
        </div>

    </div>



@endsection

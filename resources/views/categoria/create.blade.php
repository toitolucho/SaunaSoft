@extends('layouts.base')
@section('content')

                <div class = "row">
					<div class = "col">
						<h1>Nueva Categorias</h1>
                    </div>
				</div>
                <div class = "row">
					<div class = "col">
						<a class="btn btn-secondary" href="/categorias"> volver a Categorias </a>
                    </div>
				</div>
                <div class = "row">
					<div class = "col">
						<form action="/categorias" method="POST">
                            @csrf
                            <div class="form-group">
                                <label for="NombreCategoria"> Nombre Categoria : </label>
                                <input type="text" class="form-control" id = "NombreCategoria" name="NombreCategoria" placeholder="Ingrese el nombre del articulo">  </input>
                            </div>
                            <button class="btn btn-primary" type="submit"> Guardar</button>
                        </form>  
					</div>
				</div>
            </div>


            <div class="card">

				<div class="card-header"><i class="fa fa-fw fa-plus-circle">
					</i> <strong>Agregar Categoria</strong>
					<a href="/categorias" class="float-right btn btn-dark btn-sm"><i class="fa fa-fw fa-globe"></i> Listado de Categorias</a>
				</div>

				<div class="card-body">
					@if ($errors->any())
						<div class="alert alert-danger">
							<ul>
								@foreach ($errors->all() as $error)
									<li>{{ $error }}</li>
								@endforeach
							</ul>
						</div>
					@endif

					<div class="col-sm-6">
						<h5 class="card-title">Los Campos con <span class="text-danger">*</span> son Obligatorios!</h5>
						<form action="/categorias" method="POST">
							@csrf
							<div class="form-group">
								<label for="NombreCategoria">Nombre de Categoria <span class="text-danger">*</span></label>
								<input type="text" name="NombreCategoria" id="NombreCategoria" class="form-control" placeholder="Ingrese el nombre del articulo" required  value="{{old('NombreCategoria')}}">
							</div>

							<div class="form-group">
								<button type="submit" name="submit" value="submit" id="submit" class="btn btn-primary"><i class="fa fa-fw fa-plus-circle"></i> Agregar Categoria</button>
							</div>

						</form>

					</div>

				</div>

			</div>

@endsection

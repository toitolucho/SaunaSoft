@extends('welcome')
@section('content')



<div class="container">
	<div class="card">

		<div class="card-header"><i class="fa fa-fw fa-plus-circle">
			</i> Edicion del Articulo <strong> {{$articulo->NombreArticulo }}</strong>
			<a href="/categorias/{{$articulo->IdCategoria}}" class="float-right btn btn-dark btn-sm"><i class="fa fa-fw fa-globe"></i> Categoria </a>
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
				<form action="{{route('articulos.update2', ["categoria" => $categoria, "articulo"=>  $articulo] )}}" method="POST">
					{{ csrf_field() }}
{{--					@csrf--}}
					<div class="form-group">
						<label for="NombreArticulo">Nombre del Articulo <span class="text-danger">*</span></label>
						<input type="text" name="NombreArticulo" id="NombreCategoria" class="form-control" placeholder="Ingrese el nombre del articulo" required  value="{{$articulo->NombreArticulo}}" >
					</div>
					<div class="form-group">
						<label for="CantidadExistencia">Existencia <span class="text-danger">*</span></label>
						<input type="text" name="CantidadExistencia" id="CantidadExistencia" class="form-control" placeholder="Existencia" required   value ="0" readonly value="{{$articulo->CantidadExistencia}}">
					</div>
					<div class="form-group">
						<label for="PrecioVigente">Precio <span class="text-danger">*</span></label>
						<input type="text" name="PrecioVigente" id="PrecioVigente" class="form-control" placeholder="Precio" required  value="0" value="{{$articulo->PrecioVigente}}">
					</div>
					<div class="form-group">
						<label for="Descripcion">Descripcion <span class="text-danger">*</span></label>
{{--						<input type="text" name="Descripcion" id="Descripcion" class="form-control" placeholder="Ingrese el nombre del articulo" required  value="{{old('NombreCategoria')}}">--}}
							<textarea class="form-control" id="Descripcion" rows="2" name="Descripcion" cols="100" placeholder="Ingrese una breve descripción del articulo"> {{$articulo->Descripcion}}</textarea>
					</div>

					<div class="form-group">
						<button type="submit" name="submit" value="submit" id="submit" class="btn btn-primary"><i class="fa fa-fw fa-plus-circle"></i> Actualizar Articulo</button>
					</div>

				</form>

			</div>

		</div>

	</div>
</div>



@endsection

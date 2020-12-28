@extends('welcome')
@section('content')



<div class="container">
	<div class="card">

		<div class="card-header"><i class="fa fa-fw fa-plus-circle">
			</i> <strong>Agregar Tipo</strong>
			<a href="{{route("tiposclientes.index")}}" class="float-right btn btn-dark btn-sm"><i class="fa fa-fw fa-globe"></i> Listado de Tipos</a>
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

			<div>
				<h5 class="card-title">Los Campos con <span class="text-danger">*</span> son Obligatorios!</h5>
				<form action="{{route("tiposclientes.store")}}" method="POST">
					@csrf
					<div class="form-row mb-2">

							<label for="Descripcion">Descripcion<span class="text-danger">*</span></label>
							<input type="text" name="Descripcion" id="Descripcion" class="form-control" placeholder="Nombre" required  value="{{old('Descripcion')}}">

					</div>


                    <div class="form-group">
                        <button type="submit" name="submit" value="submit" id="submit" class="btn btn-primary"><i class="fa fa-fw fa-plus-circle"></i> Agregar Tipo</button>
                    </div>

				</form>

			</div>

		</div>

	</div>
</div>



@endsection

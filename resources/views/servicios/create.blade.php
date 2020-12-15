@extends('welcome')
@section('content')



<div class="container">
	<div class="card">

		<div class="card-header"><i class="fa fa-fw fa-plus-circle">
			</i> <strong>Agregar Servicios</strong>
			<a href="/servicios" class="float-right btn btn-dark btn-sm"><i class="fa fa-fw fa-globe"></i> Listado de Servicios</a>
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
				<form action="{{route("servicios.store")}}" method="POST">
					@csrf
					<div class="form-row">
						<div class="form-group col-md-7">
							<label for="NombreServicio">Nombre del Servicio<span class="text-danger">*</span></label>
							<input type="text" name="NombreServicio" id="NombreServicio" class="form-control" placeholder="Nombre del Servicio" required  value="{{old('NombreServicio')}}">
						</div>
						<div class="form-group col-md-3">
                            <label for="CostoServicio">Costo  del Servicio<span class="text-danger">*</span></label>
                            <input type="text" name="CostoServicio" id="CostoServicio" class="form-control" placeholder="Costo  del Servicio" required  value="{{old('CostoServicio')}}">
						</div>
					</div>

                    <div class="form-row">
                        <label for="Descripcion">Descripcion<span class="text-danger">*</span></label>
                        <input type="text" name="Descripcion" id="Descripcion" class="form-control" placeholder="Descripcion" required  value="{{old('Descripcion')}}">
                    </div>
                    <div class="form-group form-check">
                        <input type="checkbox" class="form-check-input" id="CodigoEstado" name="CodigoEstado" value = "A" checked>
                        <label class="form-check-label" for="CodigoEstado">Activo?</label>
                    </div>

                    <div class="form-group">
                        <button type="submit" name="submit" value="submit" id="submit" class="btn btn-primary"><i class="fa fa-fw fa-plus-circle"></i> Agregar Categoria</button>
                    </div>

				</form>

			</div>

		</div>

	</div>
</div>



@endsection

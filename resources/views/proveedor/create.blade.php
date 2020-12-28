@extends('welcome')
@section('content')



<div class="container">
	<div class="card">

		<div class="card-header"><i class="fa fa-fw fa-plus-circle">
			</i> <strong>Agregar Proveedor</strong>
			<a href="{{route("proveedores.index")}}" class="float-right btn btn-dark btn-sm"><i class="fa fa-fw fa-globe"></i> Listado de Proveedor</a>
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
				<form action="{{route("proveedores.store")}}" method="POST">
					@csrf
					<div class="form-row">
						<div class="form-group col-md-5">
							<label for="NombreRazonSocial">Nombre Proveedor<span class="text-danger">*</span></label>
							<input type="text" name="NombreRazonSocial" id="NombreRazonSocial" class="form-control" placeholder="Nombre del Proveedor" required  value="{{old('NombreRazonSocial')}}">
						</div>
						<div class="form-group col-md-5">
                            <label for="NombreRepresentante">Representante<span class="text-danger">*</span></label>
                            <input type="text" name="NombreRepresentante" id="NombreRepresentante" class="form-control" placeholder="Representante" required  value="{{old('NombreRepresentante')}}">
						</div>
					</div>
                    <div class="form-row">
                        <div class="form-group col-md-5">
                            <label for="Direccion">Direccion</label>
                            <input type="text" name="Direccion" id="Direccion" class="form-control" placeholder="Direccion"   value="{{old('Direccion')}}">
                        </div>
                        <div class="form-group col-md-5">
                            <label for="NroCelular">Teléfono</label>
                            <input type="number" name="NroCelular" id="NroCelular" class="form-control" placeholder="NroCelular"   value="{{old('NroCelular')}}">
                        </div>
                    </div>


                    <div class="form-group">
                        <button type="submit" name="submit" value="submit" id="submit" class="btn btn-primary"><i class="fa fa-fw fa-plus-circle"></i> Agregar Proveedor</button>
                    </div>

				</form>

			</div>

		</div>

	</div>
</div>



@endsection

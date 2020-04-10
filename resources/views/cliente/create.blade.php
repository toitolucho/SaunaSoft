


@extends('welcome')
@section('content')



<div class="container">
	<div class="card">

		<div class="card-header"><i class="fa fa-fw fa-plus-circle">
			</i> <strong>Agregar Cliente</strong>
			<a href="/clientes" class="float-right btn btn-dark btn-sm"><i class="fa fa-fw fa-globe"></i> Listado de Clientes</a>
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
				<form action="/clientes" method="POST">
					@csrf
					<div class="form-group">
						<label for="Nombres">Nombre de Cliente <span class="text-danger">*</span></label>
						<input type="text" name="Nombres" id="Nombres" class="form-control" placeholder="Ingrese el nombre del cliente" required  value="{{old('Nombres')}}">
					</div>
					<div class="form-group">
						<label for="Apellidos">Apellidos del Cliente <span class="text-danger">*</span></label>
						<input type="text" name="Apellidos" id="Apellidos" class="form-control" placeholder="Ingrese el/los apellidos" required  value="{{old('Apellidos')}}">
					</div>
					<div class="form-group">
						<label for="NroCelular">Nro de Celular </label>
						<input type="tel" name="NroCelular" id="NroCelular" class="form-control" placeholder="Celular" required  value="{{old('NroCelular')}}">
					</div>

					<div class="form-group">
						<label for="CorreoElectronico">Correo Electronico </label>
						<input type="email" name="CorreoElectronico" id="CorreoElectronico" class="form-control" placeholder="Correo" required  value="{{old('CorreoElectronico')}}">
					</div>

					<div class="form-group">
{{--						<label for="FechaNacimiento">Fecha de Nacimiento </label>--}}
{{--						<input type="text" name="FechaNacimiento" id="FechaNacimiento" class="form-control" placeholder="" required  value="{{old('FechaNacimiento')}}">--}}
{{--						<input type="text" class="form-control">--}}
{{--						<div class="input-group-addon">--}}
{{--							<span class="glyphicon glyphicon-th"></span>--}}
{{--						</div>--}}
						<label for="FechaNacimiento">Fecha de Nacimiento<span class="text-danger">*</span></label>
						<input type="date" name="FechaNacimiento" id="FechaNacimiento" class="form-control" placeholder="dd/mm/aaaa" required  value="{{old('FechaNacimiento ')}}" pattern="[0-9]{2}/[0-9]{2}/[0-9]{4}">

					</div>

{{--						<div class="input-append date" id="dp3" data-date="12-02-2012" data-date-format="dd-mm-yyyy">--}}
{{--							<input class="form-control datepicker" size="16" type="text" name="FechaNacimiento"  value="{{old('FechaNacimiento')}}>--}}
{{--							<span class="add-on"> <i class="icon-calendar"></i> </span>--}}
{{--						</div>--}}
					<div class="form-group">
						<button type="submit" name="submit" value="submit" id="submit" class="btn btn-primary"><i class="fa fa-fw fa-plus-circle"></i> Agregar Cliente</button>
					</div>

				</form>

			</div>

		</div>

	</div>
</div>



@endsection

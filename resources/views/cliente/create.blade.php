


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

			<div >
				<h5 class="card-title">Los Campos con <span class="text-danger">*</span> son Obligatorios!</h5>
				<form action="/clientes" method="POST">
					@csrf
                    <div class="form-row">
                        <div class="form-group col-md-5">
                            <label for="Nombres">Nombre de Cliente <span class="text-danger">*</span></label>
                            <input type="text" name="Nombres" id="Nombres" class="form-control" placeholder="Ingrese el nombre del cliente" required  value="{{old('Nombres')}}">
                        </div>
                        <div class="form-group col-md-5">
                            <label for="Apellidos">Apellidos del Cliente <span class="text-danger">*</span></label>
                            <input type="text" name="Apellidos" id="Apellidos" class="form-control" placeholder="Ingrese el/los apellidos" required  value="{{old('Apellidos')}}">
                        </div>

                        <div class="form-group col-md-2">
                            <label for="Ci">Ci </label>
                            <input type="text" name="Ci" id="Ci" class="form-control" placeholder="Carnet de Identidad"   value="{{old('Ci')}}">
                        </div>

                    </div>

					<div class="form-row">

                        <div class="form-group col-md-4">
                            <label for="NroCelular">Nro de Celular </label>
                            <input type="tel" name="NroCelular" id="NroCelular" class="form-control" placeholder="Celular"   value="{{old('NroCelular')}}">
                        </div>

                        <div class="form-group col-md-4">
                            <label for="IdTipoCliente">Tipo </label>
                            <select name="IdTipoCliente" class="form form-control input-group-sm">
                                @foreach($tiposClientes as $tipo)
                                    <option value="{{$tipo->IdTipoCliente}}" > {{$tipo->Descripcion}} </option>
                                @endforeach

                            </select>

                        </div>

                        <div class="form-group col-md-4">
                            {{--						<label for="FechaNacimiento">Fecha de Nacimiento </label>--}}
                            {{--						<input type="text" name="FechaNacimiento" id="FechaNacimiento" class="form-control" placeholder="" required  value="{{old('FechaNacimiento')}}">--}}
                            {{--						<input type="text" class="form-control">--}}
                            {{--						<div class="input-group-addon">--}}
                            {{--							<span class="glyphicon glyphicon-th"></span>--}}
                            {{--						</div>--}}
                            <label for="FechaNacimiento">Fecha de Nacimiento<span class="text-danger">*</span></label>
                            <input type="date" name="FechaNacimiento" id="FechaNacimiento" class="form-control" placeholder="dd/mm/aaaa"   value="{{old('FechaNacimiento ')}}" pattern="[0-9]{2}/[0-9]{2}/[0-9]{4}">

                        </div>

					</div>



                    <div class="form-group col-md-6">
                        <div class="row">
                            <label for="Sexo"> Sexo</label>
                        </div>
                        <div class="custom-control custom-radio custom-control-inline">
                            <input type="radio" class="custom-control-input" id="defaultInline1" name="Sexo" value="M">
                            <label class="custom-control-label" for="defaultInline1">Masculino</label>
                        </div>

                        <!-- Default inline 2-->
                        <div class="custom-control custom-radio custom-control-inline">
                            <input type="radio" class="custom-control-input" id="defaultInline2" name="Sexo" value="F">
                            <label class="custom-control-label" for="defaultInline2">Femenino</label>
                        </div>


                    </div>



					<div class="form-group">
						<label for="CorreoElectronico">Correo Electronico </label>
						<input type="email" name="CorreoElectronico" id="CorreoElectronico" class="form-control" placeholder="Correo"   value="{{old('CorreoElectronico')}}">
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

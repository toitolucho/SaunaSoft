@extends('welcome')
@section('content')



<div class="container">
	<div class="card">

		<div class="card-header"><i class="fa fa-fw fa-plus-circle">
			</i> <strong>Agregar Membresias</strong>
			<a href="/membresia" class="float-right btn btn-dark btn-sm"><i class="fa fa-fw fa-globe"></i> Listado de Membresia</a>
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

			<div class="col-sm-12">
				<h5 class="card-title">Los Campos con <span class="text-danger">*</span> son Obligatorios!</h5>
				<form action="/Minsertar" method="POST">
					@csrf
					<div class="form-row col-md-12">
						<div class="form-group col-md-4">
					      <label for="inputState">Cliente<span class="text-danger">*</span></label>
					      <select name="IdCliente" id="IdCliente" class="form-control">
					      	@foreach($clientes as $cliente)
					        	<option value="{{$cliente->IdCliente}}">{{$cliente->Apellidos}} {{$cliente->Nombres}}</option>
					        {{csrf_field()}}
					        @endforeach
					      </select>
					    </div>
						<div class="form-group col-md-4">
							<label for="inputState">Fecha Inicio<span class="text-danger">*</span></label>
							<input type="date" name="FechaInicio" id="FechaInicio" class="form-control" placeholder="Ingrese La Fecha Inicio" required  value="{{old('FechaInicio ')}}">
						</div>
						<div class="form-group col-md-4">
							<label for="inputState">Fecha Final<span class="text-danger">*</span></label>
							<input type="date" name="FechaFin" id="FechaFin" class="form-control" placeholder="Ingrese La Fecha Final" required  value="{{old('FechaFin')}}">
						</div>
						<div class="form-group col-md-6">
					      <label for="inputState">Estado</label>
					      <select name="CodigoEstado" id="CodigoEstado" class="form-control">
					        <option selected value="V">VIGENTE</option>
					        <option value="C">CONCLUIDO</option>
					      </select>
					    </div>
						<div class="form-group col-md-6">
							<label for="CostoGeneral">Costo General  <span class="text-danger">*</span></label>
							<input type="text" name="CostoGeneral" id="CostoGeneral" class="form-control" placeholder="Ingrese Costo General" required  value="{{old('CostoGeneral')}}">
						</div>



						<div class="form-group">
							<button type="submit" name="submit" value="submit" id="submit" class="btn btn-primary"><i class="fa fa-fw fa-plus-circle"></i> Agregar Categoria</button>
						</div>
					</div>
				</form>

			</div>

		</div>

	</div>
</div>



@endsection

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.7.1/css/bootstrap-datepicker3.standalone.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.7.1/js/bootstrap-datepicker.min.js"></script>
<script type="text/javascript">
    // $('#FechaNacimiento').datepicker({
    // 	format: 'dd/mm/yyyy'
    // 	//startDate: '-3d'
    // });
    $(function () {
        $('#FechaNacimiento').datepicker()({
            dateFormat: 'dd-mm-yy'
        });


    });
</script>

@extends('welcome')
@section('content')


    <div class="container">
        <div class="card">

            <div class="card-header"><i class="fa fa-fw fa-plus-circle">
                </i> <strong>Modificar Cliente {{$cliente->IdCliente}}</strong>
                <a href="/clientes" class="float-right btn btn-dark btn-sm"><i class="fa fa-fw fa-globe"></i> Listado de Clientes</a>
            </div>




                <div class = "row m-lg-2">
					<div class = "col">
						<form action="/clientes/{{$cliente->IdCliente}}" method="POST">
                            @csrf
                            @method('put')
                            <div class="form-group">
                                <label for="Nombres">Nombre de Cliente <span class="text-danger">*</span></label>
                                <input type="text" name="Nombres" id="Nombres" class="form-control" placeholder="Ingrese el nombre del cliente" required  value="{{$cliente->Nombres}}">
                            </div>
                            <div class="form-group">
                                <label for="Apellidos">Apellidos del Cliente <span class="text-danger">*</span></label>
                                <input type="text" name="Apellidos" id="Apellidos" class="form-control" placeholder="Ingrese el/los apellidos" required  value="{{$cliente->Apellidos}}">
                            </div>
							<div class="form-group">
                                <label for="Ci">Carnet de Identidad </label>
                                <input type="text" name="Ci" id="Ci" class="form-control" placeholder="Ci"   value="{{$cliente->ci}}">
                            </div>
                            <div class="form-group">
                                <label for="NroCelular">Nro de Celular </label>
                                <input type="tel" name="NroCelular" id="NroCelular" class="form-control" placeholder="Celular"   value="{{$cliente->NroCelular}}">
                            </div>

                            <div class="form-group">
                                <label for="CorreoElectronico">Correo Electronico </label>
                                <input type="email" name="CorreoElectronico" id="CorreoElectronico" class="form-control" placeholder="Correo"   value="{{$cliente->CorreoElectronico}}">
                            </div>
							
							<div class="form-group">
								<label for="IdTipoCliente">Tipo </label>
								<select name="IdTipoCliente" class="form form-control input-group-sm">
									@foreach($tiposClientes as $tipo)
										@if($tipo->IdTipoCliente == $cliente->IdTipoCliente)
											<option value="{{$tipo->IdTipoCliente}}"  selected > {{$tipo->Descripcion}}  </option>
										@else
											<option value="{{$tipo->IdTipoCliente}}"  > {{$tipo->Descripcion}}  </option>
										@endif
									@endforeach

								</select>
							</div>

                            <div class="form-group">
                                <label for="FechaNacimiento">Fecha de Nacimiento</label>
                                <input type="date" name="FechaNacimiento" id="FechaNacimiento" class="form-control" placeholder="Ingrese La Fecha de nacimiento"
                                        value="{{ \Carbon\Carbon::parse($cliente->FechaNacimiento)->format('Y-m-d')}}">

                            </div>
							<div class="form-group col-md-6">
								<div class="row">
									<label for="Sexo"> Sexo</label>
								</div>
								<div class="custom-control custom-radio custom-control-inline">
									<input type="radio" class="custom-control-input" id="defaultInline1" name="Sexo" value="M"  @if($cliente->Sexo == 'M') checked @endif>
									
										<label class="custom-control-label" for="defaultInline1" >Masculino</label>
								</div>

								<!-- Default inline 2-->
								<div class="custom-control custom-radio custom-control-inline">
									<input type="radio" class="custom-control-input" id="defaultInline2" name="Sexo" value="F" @if($cliente->Sexo == 'F') checked @endif>
									<label class="custom-control-label" for="defaultInline2">Femenino</label>
								</div>


							</div>
                            <button class="btn btn-primary" type="submit"> <i class="fa fa-fw far fa-save"></i> Guardar</button>

                        </form>
					</div>
				</div>
        </div>

    </div>



@endsection

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
                                <label for="NroCelular">Nro de Celular </label>
                                <input type="tel" name="NroCelular" id="NroCelular" class="form-control" placeholder="Celular" required  value="{{$cliente->NroCelular}}">
                            </div>

                            <div class="form-group">
                                <label for="CorreoElectronico">Correo Electronico </label>
                                <input type="email" name="CorreoElectronico" id="CorreoElectronico" class="form-control" placeholder="Correo" required  value="{{$cliente->CorreoElectronico}}">
                            </div>

                            <div class="form-group">
                                <label for="FechaNacimiento">Fecha de Nacimiento </label>
                                <input type="text" name="FechaNacimiento" id="FechaNacimiento" class="form-control" placeholder="" required  value="{{$cliente->FechaNacimiento}}">

                                <div class="input-group-addon">
                                    <span class="glyphicon glyphicon-th"></span>
                                </div>
                                {{--						<div class="input-append date" id="dp3" data-date="12-02-2012" data-date-format="dd-mm-yyyy">--}}
                                {{--							<input class="form-control datepicker" size="16" type="text" name="FechaNacimiento"  value="{{old('FechaNacimiento')}}>--}}
                                {{--							<span class="add-on"> <i class="icon-calendar"></i> </span>--}}
                                {{--						</div>--}}
                            </div>
                            <button class="btn btn-primary" type="submit"> <i class="fa fa-fw far fa-save"></i> Guardar</button>

                        </form>
					</div>
				</div>
        </div>

    </div>



@endsection

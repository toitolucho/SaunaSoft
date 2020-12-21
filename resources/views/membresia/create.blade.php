@extends('welcome')
@section('content')

    <style>
        #scrollable-dropdown-menu .tt-dropdown-menu {
            max-height: 150px;
            overflow-y: auto;
        }

        .twitter-typeahead, .tt-hint, .tt-input, .tt-menu { width: 100%; }



    </style>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/livequery/1.1.1/jquery.livequery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/corejs-typeahead/1.3.0/typeahead.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/corejs-typeahead/1.3.0/typeahead.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootbox.js/5.4.0/bootbox.min.js"></script>


    <script type="text/javascript">

    $(document).ready(function(){
        var clientes = new Bloodhound({
            remote: {
                url: '/buscarclientesAjax?q=QUERY',
                wildcard: 'QUERY'
            },
            datumTokenizer: Bloodhound.tokenizers.whitespace('NombreCompleto'),
            queryTokenizer: Bloodhound.tokenizers.whitespace
        });
        console.log(clientes);



        $("#textoCliente").typeahead({
            hint: true,
            highlight: true,
            limit: 10,
            minLength: 2
        }, {
            source: clientes.ttAdapter(),
            display: 'NombreCompleto',

            // This will be appended to "tt-dataset-" to form the class name of the suggestion menu.
            name: 'listaClientes',

            // the key from the array we want to display (name,id,email,etc...)
            templates: {
                empty: [
                    '<div class="list-group search-results-dropdown"><div class="list-group-item">Cliente no encontrado</div></div>'
                ],
                header: [
                    '<div class="list-group search-results-dropdown">'
                ],
                suggestion: function (data) {

                    return ('<div class="list-group-item" >' + data.NombreCompleto + '</div>');
                }
            }
        }).on('typeahead:selected', function(event, data) {
            var nombreCompleto = data.NombreCompleto;
            var IdCliente = data.IdCliente;


            $('#formMembresia input[name=\"IdCliente\"]').val(IdCliente)


        });
    });
</script>






<div class="container">
	<div class="card">

		<div class="card-header"><i class="fa fa-fw fa-plus-circle">
			</i> <strong>Agregar Membresias</strong>
			<a href="{{route("membresias.index")}}" class="float-right btn btn-dark btn-sm"><i class="fa fa-fw fa-globe"></i> Listado de Membresia</a>
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
				<form action="{{route("membresias.store")}}" method="POST" id="formMembresia">
					@csrf
					<div class="form-row col-md-12">

                        <div class="form-group col-md-6">
                            <label for="textoCliente" >Seleccione Cliente<span class="text-danger" >*</span></label>
                            <input type="search" name="NombreCliente" class="form-control typeahead" placeholder="Cliente" autocomplete="off" id="textoCliente" required value="{{old('NombreCliente')}}">
                            <div class="invalid-feedback">
                                Porfavor seleccione un cliente.
                            </div>


                            <input type="hidden" name="IdCliente"   value="{{old('IdCliente')}}" />
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
							<button type="submit" name="submit" value="submit" id="submit" class="btn btn-primary"><i class="fa fa-fw fa-plus-circle"></i> Agregar Membresia</button>
						</div>
					</div>
				</form>

			</div>

		</div>

	</div>
</div>



@endsection

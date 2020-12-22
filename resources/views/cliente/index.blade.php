@extends('welcome')
@section('content')


    @include('utilidades.delete_modal')
    <style>
        .listado {
            list-style-type: none !important;
        }

        .close {
            color: #fff;
            opacity: 1;
        }


    </style>

    <!-- Dialog show event handler -->
    <script type="text/javascript">

        $(function () {
            $('[data-toggle="tooltip"]').tooltip()

            $('.alert-success').fadeIn().delay(1500).fadeOut(1000);


            $('#agregarMembresia').on('show.bs.modal', function (event) {


                var button = $(event.relatedTarget) // Button that triggered the modal
                var idCliente = button.data('idcliente') // Extract info from data-* attributes
                // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
                // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
                var modal = $(this)
                //modal.find('.modal-title').text('New message to ' + recipient)
                // console.log(button.data())
                // console.log(button.data('idcliente'))
                modal.find('.modal-body #txtIdCliente').val(idCliente)
            })

        });


    </script>



    <!-- Modal Add Edit Membresia-->
    <div class="modal fade" id="agregarMembresia" tabindex="-1" role="dialog" aria-labelledby="agregarMembresiaLabel" aria-hidden="true">

        <div class="modal-dialog modal-notify modal-info" role="document">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title" id="agregarMembresiaLabel">Agregar membresia nueva</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true" >&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form action = "{{route("membresias.store")}}" method="post">
{{--                    <form action="/clientes" method="POST">--}}
                    @csrf

{{--                        idCliente--}}
                        <input id="txtIdCliente" type="text" value=""  name="IdCliente" hidden>
                        <div class="form-group  col-md-6">
                            <label for="inputState">Fecha Inicio<span class="text-danger">*</span></label>
                            <input type="date" name="FechaInicio" id="FechaInicio" class="form-control" placeholder="Ingrese La Fecha Inicio" required  value="{{old('FechaInicio ')}}">
                        </div>
                        <div class="form-group  col-md-6">
                            <label for="inputState">Fecha Final<span class="text-danger">*</span></label>
                            <input type="date" name="FechaFin" id="FechaFin" class="form-control" placeholder="Ingrese La Fecha Final" required  value="{{old('FechaFin')}}">
                        </div>
                        <div class="form-group  col-md-6">
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


                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                            <button type="submit" class="btn btn-primary">Guardar</button>
                        </div>

                    </form>
                </div>

            </div>
        </div>
    </div>



    <h1 class="h3 mb-2 text-gray-800"><i class="fas fa-user-friends"></i> Clientes</h1>
    <p class="mb-4">A continuación se muestra el listado de clientes que dispone para poder clasificar los articulos
        del sistema para una administración más sencilla. Si tiene alguna duda de como administrarlos consulte con el
        administrador <a target="_blank" href="https://datatables.net">administrador </a>.</p>

    <div class="card shadow mb-4">
        <div class="card-header py-3"><i class="fa fa-fw fa-globe"></i> <strong>Listado de Clientes</strong>

            {{--				<h6 class="m-0 font-weight-bold text-primary">Listado de clientes</h6>--}}


            <a href="/clientes/create" class="float-right btn btn-dark btn-sm"><i class="fa fa-fw fa-plus-circle"></i>
                Agregar cliente</a></div>





        <div class="row  my-2">
            <div class="col-sm-12 col-md-8"></div>
            <div class="col-sm-12 col-md-4 " >

                    <form class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 " action="/clientes/buscar" method="POST" role="search">
                        {{ csrf_field() }}
                        <div class="input-group">


                            <input type="text" class="form-control bg-light border-0 small" placeholder="nombre o apellido..." aria-label="Search" aria-describedby="basic-addon2" name="Nombrecliente">
                            <div class="input-group-append">
                                <button class="btn btn-primary" type="submit">
                                    <i class="fas fa-search fa-sm"></i>
                                </button>
                            </div>
                        </div>
                    </form>


            </div>
        </div>


        <div class="card-body">

            @if (session('eliminar'))
                <div class="alert alert-success"><i class="fa fa-thumbs-up"></i>
                    {{ session('eliminar') }}
                </div>formConfirm


            @endif

            @if (session('eliminar_error'))
                <div class="alert alert-danger"><i class="fa fa-exclamation-triangle"></i>
                    {{ session('eliminar_error') }}
                </div>


            @endif
            @if (session('editado'))
                <div class="alert alert-success"><i class="fa fa-thumbs-up"></i>
                    {{ session('editado') }}
                </div>


            @endif

            @if (session('editado_error'))
                <div class="alert alert-danger"><i class="fa fa-exclamation-triangle"></i>
                    {{ session('editado_error') }}
                </div>


            @endif

            @if (session('no_encontrado'))
                <div class="alert alert-danger"><i class="fa fa-exclamation-triangle"></i>
                    {{ session('no_encontrado') }}
                </div>


            @endif


            <div class="table-responsive">
                <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">

                    <div class="row">
                        <div class="col-sm-12">
                            <table class="table table-bordered dataTable" id="dataTable" width="100%" cellspacing="0"
                                   role="grid" aria-describedby="dataTable_info">

                                <thead>
                                <tr role="row">

                                    <th class="w-5">
                                        Id
                                    </th>
                                    <th class="w-35">
                                        Nombre cliente
                                    </th>
                                    <th class="w-10">
                                        Celular
                                    </th>
                                    <th class="w-30">
                                        Correo
                                    </th>
                                    <th class="w-10">
                                        Fecha Nac.
                                    </th>
                                    <th class="w-10">
                                        Acciones
                                    </th>

                                </tr>
                                </thead>

                                <tbody>
                                @foreach($clientes as $cliente)
                                    <tr role="row">
{{--                                        <td>--}}
{{--											<span class="custom-checkbox">--}}
{{--											<input type="checkbox" id="checkbox1" name="options[]" value="1">--}}
{{--											<label for="checkbox1"></label>--}}
{{--											</span>--}}
{{--                                        </td>--}}
                                        <td class="w-5"><a href="clientes/{{$cliente->IdCliente}}"> {{$cliente->IdCliente}} </a>  </td>
                                        <td class="w-35">{{$cliente->Nombres . " " . $cliente->Apellidos}}  </td>
                                        <td class="w-10">{{$cliente->NroCelular}}  </td>
                                        <td class="w-30">{{$cliente->CorreoElectronico}}  </td>
                                        <td class="w-10">{{ date('d-m-Y', strtotime($cliente->FechaNacimiento)) }}  </td>

                                        <td class="w-10 text-center">
                                            <li data-form="#delete-form-{{$cliente->IdCliente}}"
                                                data-title="Eliminar Cliente"
                                                data-message="Se encuentra seguro de eliminar este cliente?"
                                                data-target="#formConfirm" class="listado">



                                                <a class="btn btn-primary " class="formConfirm text-primary"
                                                   href="{{route("clientes.edit", $cliente->IdCliente )}}"
                                                   data-toggle="tooltip" data-placement="top" title="Modificar datos"
                                                    aria-label="Editar">
                                                        <i class="fas fa-xs fa-edit" aria-hidden="true"></i>
                                                </a>

{{--                                                <span data-toggle="modal" data-target="#formConfirm">--}}
                                                <a data-toggle="tooltip" class="formConfirm btn btn-danger"
                                                   data-placement="top" title="Eliminar cliente" href="">
                                                        <i class="fas fa-xs fa-trash" aria-hidden="true"></i>

                                                </a>
{{--                                                </span>--}}

{{--                                                <span data-toggle="modal" data-target="#agregarMembresia" >--}}
{{--                                                    <a class="btn btn-info " class="formConfirm text-primary"--}}
{{--                                                       data-toggle="tooltip" href=""--}}
{{--                                                       data-placement="top" title="Designar Membresia">--}}
{{--                                                        <i class="fas fa-xs fa-id-card" aria-hidden="true"></i>--}}
{{--                                                    </a>--}}
{{--                                                </span>--}}

                                                <span data-toggle="modal" data-target="#agregarMembresia" data-idCliente="{{$cliente->IdCliente}}">
                                                    <button type*="button" class="btn btn-info"
                                                            data-placement="top" title="Designar Membresia"

                                                            data-toggle="tooltip" value="">
                                                        <i class="fas fa-xs fa-id-card" aria-hidden="true"></i>
                                                    </button>
                                                </span>


                                                <a class="btn btn-warning " class="formConfirm text-primary"
                                                   href="{{route("clientes.edit", $cliente->IdCliente )}}"
                                                   data-toggle="tooltip" data-placement="top" title="Asignar Promociones"
                                                   aria-label="Promociones">
                                                    <i class="fas fa-xs fa-tags" aria-hidden="true"></i>
                                                </a>



                                            </li>

                                            <form id="delete-form-{{$cliente->IdCliente}}"
{{--                                                  action="/clientes/{{$cliente->IdCliente}}" method="post"--}}
                                                    action = "{{route("clientes.destroy", $cliente->IdCliente )}}" method="post"
                                                  style="display: none">
                                                <input type="hidden" name="_method" value="delete">
                                                {{csrf_field()}}

                                            </form>

                                        </td>


                                    </tr>
                                @endforeach


                                </tbody>

                            </table>

                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12 col-md-7">
                            {{ $clientes->links() }}
                        </div>
                    </div>
                </div>
            </div>

        </div>

    </div>

    <div>






    </div> <!--/.col-sm-12-->


@endsection




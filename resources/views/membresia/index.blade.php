@extends('welcome')
@section('content')

    <style>
        .listado {
            list-style-type: none !important;
        }
    </style>

    <!-- Dialog show event handler -->
    <script type="text/javascript">

        $(function () {
            $(".formConfirm").click(function (e) {
                e.preventDefault();
                var el = $(this).parent();
                var title = el.attr('data-title');
                var msg = el.attr('data-message');
                var dataForm = el.attr('data-form');


                $('#formConfirm')
                    .find('#frm_body').html(msg)
                    .end().find('#frm_title').html(title)
                    .end().modal('show');

                $('#formConfirm').find('#frm_submit').attr('data-form', dataForm);

            });
        });
        $(function () {
            $("#frm_submit").click(function (e) {
                //console.log("registro a eliminar")
                var id = $(this).attr('data-form');
                console.log("entra confirm" + id);
                $(id).submit();
            });

        });

    </script>

    <!-- Modal Dialog -->
    <div class="modal fade" id="formConfirm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="frm_title">Eliminar registro</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                        <span class="sr-only">Cerrar</span>
                    </button>

                </div>


                <div class="modal-body" id="frm_body"></div>
                <div class="modal-footer">
                    <button style='margin-left:10px;' type="button" class="btn btn-primary col-sm-2 pull-right"
                            id="frm_submit">Aceptar
                    </button>
                    <button type="button" class="btn btn-danger col-sm-2 pull-right" data-dismiss="modal"
                            id="frm_cancel">Cancelar
                    </button>
                </div>
            </div>
        </div>
    </div>



    <h1 class="h3 mb-2 text-gray-800"><i class="fas fa-address-card"></i> Membresia</h1>
    <p class="mb-4">Listado de clientes asociados a una membresia </a>.</p>

    <div class="card shadow mb-4">
        <div class="card-header py-3"><i class="fa fa-fw fa-globe"></i> <strong>Listado de Membresia</strong>

            {{--				<h6 class="m-0 font-weight-bold text-primary">Listado de Membresia</h6>--}}


            <a href="{{route("membresias.create")}}" class="float-right btn btn-dark btn-sm"><i class="fa fa-fw fa-plus-circle"></i>
                Agregar Membresia</a></div>

        <div class="row  my-2">
            <div class="col-sm-12 col-md-8"></div>
            <div class="col-sm-12 col-md-4 " >

                    <form class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 " action="{{route("membresia.buscar")}}" method="POST" role="search">
                        {{ csrf_field() }}
                        <div class="input-group">


                            <input type="text" class="form-control bg-light border-0 small" placeholder="nombre cliente..." aria-label="Search" aria-describedby="basic-addon2" name="NombreCliente">
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
                </div>


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
                                   role="grid" aria-describedby="dataTable_info" style="width: 100%;">

                                <thead>
                                <tr role="row">
                                    <th class="w-10 text-center">Id</th>
                                    <th class="w-30 text-center">Cliente</th>
                                    <th class="w-14 text-center">F. Inicio</th>
                                    <th class="w-14 text-center">F. Final</th>
                                    <th class="w-14 text-center">Estado</th>
                                    <th class="w-14 text-center">Costo</th>
                                    <th class="w-6 text-center">Acciones</th>

                                </tr>
                                </thead>

                                <tbody>
                                @foreach($membresias as $membresia)
                                    <tr role="row">
                                        <td class="w-10 text-center">
											{{$membresia->IdMembresia}}
                                        </td>
                                        <td>@if($membresia->cliente != null)  {{$membresia->cliente->NombreCompleto}} @endif</td>
                                        <td> {{   date('d-m-Y', strtotime($membresia->FechaInicio))   }}</td>
                                        <td>{{   date('d-m-Y', strtotime($membresia->FechaFin))   }}</td>
                                        <td>{{$membresia->Estado }}  </td>
                                        <td class="w-10 text-right">{{$membresia->CostoGeneral }}  </td>

                                        <td class="w-7 text-center">

                                            <li data-form="#delete-form-{{$membresia->IdMembresia}}"
                                                data-title="Eliminar Promocion"
                                                data-message="Se encuentra seguro de eliminar esta promocion?"
                                                data-target="#formConfirm" class="listado">



                                                <a class="btn btn-primary " class="formConfirm text-primary"
                                                   href="{{route("membresias.edit", $membresia->IdMembresia )}}"
                                                   aria-label="Editar">
                                                    <i class="fas fa-xs fa-edit" aria-hidden="true"></i>
                                                </a>


                                                <a data-toggle="modal" class="formConfirm btn btn-danger" href=""
                                                   data-target="#formConfirm">
                                                    <i class="fas fa-xs fa-trash" aria-hidden="true"></i>

                                                </a>

                                            </li>

                                            <form id="delete-form-{{$membresia->IdMembresia}}"
                                                  action = "{{route("membresias.destroy", $membresia->IdMembresia )}}" method="post"
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
                            {{ $membresias->links() }}
                        </div>
                    </div>
                </div>
            </div>

        </div>

    </div>

    <div>






    </div> <!--/.col-sm-12-->


@endsection




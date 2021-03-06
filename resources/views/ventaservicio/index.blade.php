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
                //console.log($(this).attr("data-ejemplo"));
                // var el = $(this).parent();
                var el = $(this);
                var title = el.attr('data-title');
                var msg = el.attr('data-message');
                var dataForm = el.attr('data-form');

                console.log(dataForm);


                $('#formConfirm')
                    .find('#frm_body').html(msg)
                    .end().find('#frm_title').html(title)
                    .end().modal('show');

                $('#formConfirm').find('#frm_submit').attr('data-form', dataForm);

            });

            $('.reporte').click(function(){
                var tipo = $(this).attr('data-tipoReporte');
                console.log("tipo reporte " + tipo);
                $('#tipoReporte').val(tipo);
                $('#tipoReporte').text(tipo);

                $('#formRangoFechas input[name=\"tipoReporte\"]').val(tipo)
                //$('#total').text('Product price: $1000');
            });
        });
        $(function () {
            $("#frm_submit").click(function (e) {
                //console.log("registro a eliminar")
                var id = $(this).attr('data-form');
                console.log("entra confirm  " + id);
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


    <!-- Modal Dialog -->
    <div class="modal fade" id="formRangoFechas" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="frm_title">Seleccione un rango de Fechas</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                        <span class="sr-only">Cerrar</span>
                    </button>

                </div>

                <form action="{{route("ventasservicios.reporteFechas")}}" method="post">
                    {{ csrf_field() }}
                    <div class="modal-body" id="frm_body">

                        <div class="form-row col-md-12">
                            <div class="form-group col-md-4">
                                <label for="inputState">Fecha Inicio<span class="text-danger">*</span></label>
                                <input type="date" name="FechaInicio" id="FechaInicio" class="form-control"
                                       placeholder="Ingrese La Fecha Inicio" required value="{{old('FechaInicio ')}}">
                            </div>
                            <div class="form-group col-md-4">
                                <label for="inputState">Fecha Final<span class="text-danger">*</span></label>
                                <input type="date" name="FechaFin" id="FechaFin" class="form-control"
                                       placeholder="Ingrese La Fecha Final" required value="{{old('FechaFin')}}">
                            </div>
                            <input name="tipoReporte"  id="tipoReporte" hidden>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button style='margin-left:10px;' type="submit" class="btn btn-primary col-sm-2 pull-right"
                                id="frm_submit">Aceptar
                        </button>
                        <button type="button" class="btn btn-danger col-sm-2 pull-right" data-dismiss="modal"
                                id="frm_cancel">Cancelar
                        </button>
                    </div>

                </form>


            </div>
        </div>
    </div>



    <h1 class="h3 mb-2 text-gray-800"><i class="fas fa-shopping-cart"></i> Registro de Ventas de Servicios y productos</h1>
    <p class="mb-4">En este formulario usted podra registrar la venta de articulos y servicios para un determinado cliente <a target="_blank" href="https://datatables.net">administrador </a>.</p>

    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <i class="fa fa-fw fa-globe"></i> <strong>Listado de Ventas</strong>

            {{--				<h6 class="m-0 font-weight-bold text-primary">Listado de Categorias</h6>--}}


            <div class="dropdown show float-right mx-2">
                <a class="btn btn-info btn-sm dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fa fa-fw fa-file"></i>
                    Resumen
                </a>

                <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                    <a data-toggle="modal" data-target="#formRangoFechas" class="dropdown-item reporte" href="#" data-tipoReporte="ResumenGlobal">Resumen Global</a>
                    <a data-toggle="modal" data-target="#formRangoFechas" class="dropdown-item reporte" href="#" data-tipoReporte="ResumenServicios">Resumen por Servicios</a>
                    <a data-toggle="modal" data-target="#formRangoFechas" class="dropdown-item reporte" href="#" data-tipoReporte="ResumenArticulos">Reseument por Articulos</a>
                    <a data-toggle="modal" data-target="#formRangoFechas" class="dropdown-item reporte" href="#" data-tipoReporte="ResumenDetallado">Reseument General Detallado</a>
{{--                    <a class="dropdown-item" href="#">Resumen por Servicios</a>--}}
{{--                    <a class="dropdown-item" href="#">Reseument por Articulos</a>--}}
                </div>
            </div>


{{--            <a data-toggle="modal" data-target="#formRangoFechas" href="#" class="float-right btn btn-info btn-sm mx-2"><i class="fa fa-fw fa-file"></i>--}}
{{--                Resumen</a>--}}



             <a href="/ventasservicios/create" class="float-right btn btn-dark btn-sm mx-2"  ><i class="fa fa-fw fa-plus-circle"></i>
                Nueva venta</a>
        </div>





        <div class="row  my-2">
            <div class="col-sm-12 col-md-8"></div>
            <div class="col-sm-12 col-md-4 " >

                    <form class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 " action="/ventasservicios/buscar" method="POST" role="search">
                        {{ csrf_field() }}
                        <div class="input-group">


                            <input type="text" class="form-control bg-light border-0 small" placeholder="Nro Venta..." aria-label="Nro venta" aria-describedby="basic-addon2" name="IdVentaServicio">
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

            @if (session('registrado'))
                <div class="alert alert-success"><i class="fa fa-exclamation-triangle"></i>
                    {{ session('registrado') }}
                </div>


            @endif


            <div class="table-responsive">
                <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">

                    <div class="row">
                        <div class="col-sm-12">
                            <table class="table table-bordered dataTable" id="dataTable" width="100%" cellspacing="0"
                                   role="grid" aria-describedby="dataTable_info" style="width: 100%;" >

                                <thead>
                                <tr role="row">


                                    <th class="w-5 text-center">Nro</th>
                                    <th class="w-15 text-center">Cliente</th>
                                    <th class="w-10 text-center">Entrada </th>
                                    <th class="w-10 text-center">Salida</th>
                                    <th class="w-10 text-center"> Servicios (Bs)</th>
                                    <th class="w-10 text-center"> Articulos (Bs)</th>
                                    <th class="w-15 text-center"> Total (Bs)</th>
                                    <th class="w-40 text-center"> Observaciones</th>
                                    <th class="w-10 text-center">Acciones</th>
                                </tr>
                                </thead>

                                <tbody>
                                @foreach($ventas as $venta)

                                    @if($venta->CodigoEstadoVenta == 'I')
                                        <tr role="row">
                                    @endif
                                    @if($venta->CodigoEstadoVenta == 'F')
                                        <tr role="row" class="table-warning">
                                    @endif
                                    @if($venta->CodigoEstadoVenta == 'A')
                                        <tr role="row" class="table-danger">
                                    @endif
                                        <td class="w-5"> {{$venta->IdVentaServicio}}</td>
                                        <td class="w-15"> @if($venta->cliente)  {{$venta->cliente->NombreCompleto }}
                                            @endif
                                        </td>
                                        <td class="w-10">   {{   date('d-m-Y H:i', strtotime($venta->FechaHoraVenta))   }}</td>
                                        <td class="w-10">  @if($venta->FechaHoraFinalizado)   {{   date('d-m-Y H:i', strtotime($venta->FechaHoraFinalizado))   }} @endif </td>
                                        <td class="w-10 text-right"> {{$venta->CostoTotalArticulos}}</td>
                                        <td class="w-10 text-right"> {{$venta->CostoTotalServicios}}</td>
                                        <td class="w-15 text-right"> {{$venta->Total}}</td>
                                        <td class="w-20">{{$venta->Observaciones}}  </td>


{{--                                        <td class="w-40 text-right">--}}
{{--                                            <ul>--}}
{{--                                                @foreach($venta->articulos as $articulo)--}}
{{--                                                    <li class="list-group-item list-group-item-info">{{ $articulo->NombreArticulo }} ({{ $articulo->pivot->Cantidad }} x {{ $articulo->pivot->Costo }} Bs)</li>--}}
{{--                                                @endforeach--}}
{{--                                            </ul>--}}

{{--                                            <ul>--}}
{{--                                                @foreach($venta->servicios as $servicio)--}}
{{--                                                    <li class="list-group-item list-group-item-light">{{ $servicio->NombreServicio }} ({{ $servicio->pivot->NroPersonas }} x {{ $servicio->pivot->Costo }}  Bs)</li>--}}
{{--                                                @endforeach--}}
{{--                                            </ul>--}}

{{--                                        </td>--}}



                                        <td class="w-10 text-center">

{{--                                            <li data-form="#delete-form-{{$venta->IdVentaServicio}}"--}}
{{--                                                data-title="Eliminar categoria"--}}
{{--                                                data-message="Se encuentra seguro de eliminar esta venta ?"--}}
{{--                                                data-target="#formConfirm" class="listado">--}}
{{--                                                <a href="{{route('ventasservicios.edit', $venta)}}"--}}
{{--                                                   class="text-primary"><i class="fa fa-fw fa-edit"></i> Editar</a>--}}


{{--                                                <a data-toggle="modal" class="formConfirm text-danger" href=""--}}
{{--                                                   data-target="#formConfirm">--}}
{{--                                                    <i class="fa fa-fw fa-trash"></i>--}}
{{--                                                    Eliminar--}}
{{--                                                </a>--}}

{{--                                            </li>--}}
                                            <li class="listado">

                                                <a class="btn btn-info"  class="formConfirm text-primary"
                                                   href="{{route("ventasservicios.reporte", $venta->IdVentaServicio  )}}"
                                                   data-toggle="tooltip" data-placement="top" title="Ver Informe"
                                                   aria-label="Informe">
                                                    <i class="fas fa-xs fa-file" aria-hidden="true"></i>
                                                </a>

                                                @if($venta->CodigoEstadoVenta == "I")
                                                    <a class="btn btn-primary " class="formConfirm text-primary"
                                                       href="{{route("ventasservicios.edit",  $venta )}}"
                                                       aria-label="Editar">
                                                        <i class="fas fa-xs fa-edit" aria-hidden="true"></i>
                                                    </a>


                                                    <a data-toggle="modal" class="formConfirm btn btn-danger" href=""
                                                       data-target="#formConfirm" data-ejemplo="{{$venta->IdVentaServicio}}"
                                                       data-form="#delete-form-{{$venta->IdVentaServicio}}"
                                                       data-title="Eliminar Venta de Servicios y Articulos"
                                                       data-message="Se encuentra seguro de eliminar esta venta?">
                                                        <i class="fas fa-xs fa-trash" aria-hidden="true"></i>

                                                    </a>

                                                    <a data-toggle="modal" class="formConfirm btn btn-success" href=""
                                                       data-target="#formConfirm" data-ejemplo="{{$venta->IdVentaServicio}}"
                                                       data-form="#finalizar-form-{{$venta->IdVentaServicio}}"
                                                       data-title="Finalizar Venta de Servicio"
                                                       data-message="¿Se encuentra seguro de finalizar los servicios registrados para esta venta? Recuerde que una vez finalizada la transaccion, los cambios son irreversibles"
                                                    >
                                                        <i class="fas fa-xs fa-check" aria-hidden="true"></i>

                                                    </a>

                                                @endif






                                            </li>

                                            @if($venta->CodigoEstadoVenta == "I")
                                                <form id="delete-form-{{$venta->IdVentaServicio}}"
                                                      action="{{route('ventasservicios.destroy', $venta)}}" method="post"
                                                      style="display: none">
                                                    <input type="hidden" name="_method" value="delete">
                                                    {{csrf_field()}}

                                                </form>
                                                <form id="finalizar-form-{{ $venta->IdVentaServicio}}"
                                                      action = "{{route("ventaservicios.finalizar",  $venta->IdVentaServicio )}}" method="post"
                                                      style="display: none">
                                                    <input type="hidden" name="_method" value="delete">
                                                    @csrf
                                                    @method('put')

                                                </form>
                                            @endif







                                        </td>


                                    </tr>
                                @endforeach


                                </tbody>

                            </table>

                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12 col-md-7">

                            @if($ventas instanceof \Illuminate\Pagination\LengthAwarePaginator )

                                {{ $ventas->links() }}

                            @endif

                        </div>
                    </div>
                </div>
            </div>

        </div>

    </div>

    <div>






    </div> <!--/.col-sm-12-->


@endsection




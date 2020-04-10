@extends('welcome')
@section('content')
    <style>
        .listado {
            list-style-type: none !important;
        }
    </style>


@include('utilidades.delete_modal');
    <div class="container">
        <div class="card">

            <div class="card-header"><i class="fa fa-fw fa-plus-circle">
                </i> Articulos de la categoria <strong> {{$categoria->NombreCategoria}}</strong>
                <a href="/categorias" class="float-right btn btn-dark btn-sm"><i class="fa fa-fw fa-globe"></i> Listado
                    de Categorias</a>
            </div>

            <div class="card-body">

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

                <div class="row">
                    <div class="col-sm-12">
                        <a href="/categorias/{{$categoria->IdCategoria}}/articulos/create"
                           class="float-right btn btn-primary btn-sm"><i class="fa fa-fw fa-plus-circle"></i>
                            Agregar Articulo</a></div>

                    <table class="table table-bordered dataTable" id="dataTable" width="100%" cellspacing="0"
                           role="grid" aria-describedby="dataTable_info" style="width: 100%;">

                        <thead>
                        <tr role="row">

                            <th class="w-5 text-center">
                                Id
                            </th>
                            <th class="w-35 text-center">
                                Articulo
                            </th>
                            <th class="w-10 text-center">
                                Existencia
                            </th>
                            <th class="w-10 text-center">
                                Precio
                            </th>
                            <th class="w-30 text-center">
                                Descripción
                            </th>
                            <th class="w-10 text-center">
                                Acciones
                            </th>

                        </tr>
                        </thead>

                        <tbody>
                        @foreach($categoria->articulos as $articulo)
                            <tr role="row">
                                <td class="w-5">{{$articulo->IdArticulo}}</td>
                                <td class="w-35">{{$articulo->NombreArticulo}}  </td>
                                <td class="w-10 text-right">{{$articulo->CantidadExistencia}}  </td>
                                <td class="w-10 text-right">{{$articulo->PrecioVigente}}  </td>
                                <td class="w-30">{{$articulo->Descripcion}}  </td>

{{--                                <td class="w-10">--}}

{{--                                    <li data-form="#delete-form-{{$articulo->IdArticulo}}"--}}
{{--                                        data-title="Eliminar Articulo"--}}
{{--                                        data-message="Se encuentra seguro de eliminar este Artículo ?"--}}
{{--                                        data-target="#formConfirm" class="listado">--}}
{{--                                        <a href="{{route('articulos.edit2',  ["categoria" => $categoria, "articulo"=> $articulo] )}}"--}}

{{--                                           class="text-primary"><i class="fa fa-fw fa-edit"></i> Editar</a>--}}
{{--										   --}}
{{--                                        <a data-toggle="modal" class="formConfirm text-danger" href=""--}}
{{--                                           data-target="#formConfirm">--}}
{{--                                            <i class="fa fa-fw fa-trash"></i>--}}
{{--                                            Eliminar--}}
{{--                                        </a>--}}

{{--                                    </li>--}}

{{--                                    <form id="delete-form-{{$articulo->IdArticulo}}"--}}
{{--                                          action="{{route('articulos.destroy2',  ["categoria" => $categoria, "articulo"=> $articulo] )}}" method="post"--}}
{{--                                          style="display: none">--}}
{{--                                        <input type="hidden" name="_method" value="delete">--}}
{{--                                        {{csrf_field()}}--}}

{{--                                    </form>--}}

{{--                                </td>--}}


                                <td class="w-10 text-center">
                                    <li data-form="#delete-form-{{$articulo->IdArticulo}}"
                                        data-title="Eliminar Articulo"
                                        data-message="Se encuentra seguro de eliminar este Articulo?"
                                        data-target="#formConfirm" class="listado">



                                        <a class="btn btn-primary " class="formConfirm text-primary"
                                           href="{{route('articulos.edit2',  ["categoria" => $categoria, "articulo"=> $articulo] )}}"
                                           aria-label="Editar">
                                            <i class="fas fa-xs fa-edit" aria-hidden="true"></i>
                                        </a>


                                        <a data-toggle="modal" class="formConfirm btn btn-danger" href=""
                                           data-target="#formConfirm">
                                            <i class="fas fa-xs fa-trash" aria-hidden="true"></i>

                                        </a>

                                    </li>

                                    <form id="delete-form-{{$articulo->IdArticulo}}"

                                          action="{{route('articulos.destroy2',  ["categoria" => $categoria, "articulo"=> $articulo] )}}" method="post"
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

        </div>





@endsection

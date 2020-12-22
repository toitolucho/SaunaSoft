@extends('welcome')
@section('content')
    <script type="text/javascript">

        $(function () {
            $('#IdCliente').val("{!! $membresia->IdCliente !!}");
            $('#CodigoEstado').val("{!! $membresia->CodigoEstado !!}");
        });
    </script>

    <div class="container">
        <div class="card">

            <div class="card-header"><i class="fa fa-fw fa-plus-circle">
                </i> <strong>Modificar Membresia</strong>
                <a href="/categorias" class="float-right btn btn-dark btn-sm"><i class="fa fa-fw fa-globe"></i> Listado
                    de Membresias</a>
            </div>


            <div class="row m-lg-2">
                <div class="col">
                    <form action="{{route("membresias.update", $membresia->IdMembresia)}}" method="POST">
                        @csrf
                        @method('put')

                        <div class="form-row col-md-12">
                            <div class="form-group col-md-4">
                                <label for="inputState">Cliente<span class="text-danger">*</span></label>
                                <select name="IdCliente" id="IdCliente" class="form-control" value="1">
                                    @foreach($clientes as $cliente)
                                        <option value="{{$cliente->IdCliente}}">{{$cliente->NombreCompleto}}</option>
                                    @endforeach
                                </select>
                            </div>
                            <div class="form-group col-md-4">
                                <label for="inputState">Fecha Inicio<span class="text-danger">*</span></label>
                                <input type="date" name="FechaInicio" id="FechaInicio" class="form-control"
                                       placeholder="Ingrese La Fecha Inicio" required
                                       value="{{ \Carbon\Carbon::parse($membresia->FechaInicio)->format('Y-m-d')}}">
                            </div>
                            <div class="form-group col-md-4">
                                <label for="inputState">Fecha Final<span class="text-danger">*</span></label>
                                <input type="date" name="FechaFin" id="FechaFin" class="form-control"
                                       placeholder="Ingrese La Fecha Final" required
                                       value="{{ \Carbon\Carbon::parse($membresia->FechaFin)->format('Y-m-d')}}">
                            </div>
                            <div class="form-group col-md-6">
                                <label for="inputState">Estado</label>
                                <select name="CodigoEstado" id="CodigoEstado" class="form-control"
                                        value="{{$membresia->CodigoEstado}}">
                                    <option value="V">VIGENTE</option>
                                    <option value="C">CONCLUIDO</option>
                                </select>
                            </div>
                            <div class="form-group col-md-6">
                                <label for="CostoGeneral">Costo General <span class="text-danger">*</span></label>
                                <input type="text" name="CostoGeneral" id="CostoGeneral" class="form-control"
                                       placeholder="Ingrese Costo General" required
                                       value="{{$membresia->CostoGeneral}}">
                            </div>

                            <div class="form-group">
                                <button type="submit" name="submit" value="submit" id="submit" class="btn btn-primary">
                                    <i class="fa fa-fw fa-plus-circle"></i> Actualizar Membresia
                                </button>
                            </div>
                        </div>

                    </form>
                </div>
            </div>
        </div>

    </div>



@endsection

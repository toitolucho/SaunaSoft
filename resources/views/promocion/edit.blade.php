@extends('welcome')
@section('content')

    <script type="text/javascript">

        $(function () {
            $('#CodigoEstado').val("{!! $promocion->CodigoEstado !!}");
            $('#TipoPromocion').val("{!! $promocion->TipoPromocion !!}");
        });
    </script>
    <div class="container">
        <div class="card">

            <div class="card-header"><i class="fa fa-fw fa-plus-circle">
                </i> <strong>Modificar Promocion</strong>
                <a href="{{route("promociones.index")}}" class="float-right btn btn-dark btn-sm"><i class="fa fa-fw fa-globe"></i> Listado de Promociones</a>
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

                <div class="col-sm-10">
                    <h5 class="card-title">Los Campos con <span class="text-danger">*</span> son Obligatorios!</h5>
                    <form action="{{route("promocion.update", $promocion->IdPromocion)}}" method="POST">
                        @csrf
                        @method('put')
                        <div class="form-row col-md-10">
                            <div class="form-group col-md-10">
                                <label for="NombrePromocion">Nombre de Promocion<span class="text-danger">*</span></label>
                                <input type="text" name="NombrePromocion" id="NombrePromocion" class="form-control" placeholder="Ingrese Nombre de la Promocion" required  value="{{$promocion->NombrePromocion}}">
                            </div>
                        </div>





                        <div class="form-row  col-md-10">
                            <div class="form-group col-md-5">
                                <label for="inputState">Fecha Inicio<span class="text-danger">*</span></label>
                                <input type="date" name="FechaInicio" id="FechaInicio" class="form-control" placeholder="Ingrese La Fecha Inicio" required   value="{{ \Carbon\Carbon::parse($promocion->FechaInicio)->format('Y-m-d')}}">
                            </div>
                            <div class="form-group col-md-5">
                                <label for="inputState">Fecha Final<span class="text-danger">*</span></label>
                                <input type="date" name="FechaFin" id="FechaFin" class="form-control" placeholder="Ingrese La Fecha Final" required  value="{{ \Carbon\Carbon::parse($promocion->FechaFin)->format('Y-m-d')}}">
                            </div>
                        </div>



                        <div class="form-row col-md-10">
                            <div class="form-group col-md-5">
                                <label for="inputState">Estado</label>
                                <select name="CodigoEstado" id="CodigoEstado" class="form-control">
{{--                                    @if($promocion->CodigoEstado == "V")--}}
{{--                                        <option selected value="V">VIGENTE</option>--}}
{{--                                    @endif--}}

                                    <option value="V">VIGENTE</option>
                                    <option value="C">CONCLUIDO</option>

                                </select>
                            </div>
                            <div class="form-group col-md-5">
                                <label for="inputState">Tipo</label>
                                <select name="TipoPromocion" id="TipoPromocion" class="form-control">
                                    <option selected value="E">POR EDAD</option>
                                    <option value="P">PERIODO DE TIEMPO</option>
                                    <option value="F">DIA FESTIVO</option>
                                    <option value="T">TIPO DE CLIENTE</option>
                                    <option value="A">ASISTENCIA Y FIDELIDAD</option>
                                    <option value="C">POR CANTIDAD DE PERSONAS</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-row col-md-10">
                            <div class="form-group col-md-5">
                                <label for="PorcentajeDescuento">Porcentaje de Descuento<span class="text-danger">*</span></label>
                                <input type="text" name="PorcentajeDescuento" id="PorcentajeDescuento" class="form-control" placeholder="Ingrese Costo General" required  value="{{$promocion->PorcentajeDescuento}}">
                            </div>
                            <div class="form-group col-md-5">
                                <label for="NroPersonas">Numero de Personas<span class="text-danger">*</span></label>
                                <input type="text" name="NroPersonas" id="NroPersonas" class="form-control" placeholder="Ingrese Nro de Personas" required  value="{{$promocion->NroPersonas}}">
                            </div>
                        </div>

                        <div class="form-group col-md-7">
                            <label for="IdServicio">Servicio </label>
                            <select name="IdServicio" class="form form-control input-group-sm">
                                <option value="" selected disabled>Ninguno</option>
                                @foreach($servicios as $servicio)
                                    <option value="{{$servicio->IdServicio}}"  @if($servicio->IdServicio == $promocion->IdServicio)  selected @endif > {{$servicio->NombreServicio}} </option>
                                @endforeach

                            </select>

                        </div>


                        <div class="form-group col-md-10">
                            <label for="Descripcion">Descripción</label>
                            {{--							<input type="text" name="Descripcion" id="Descripcion" class="form-control" placeholder="Ingrese Costo General" required  value="{{old('Descripcion')}}">--}}
                            <textarea class="form-control" id="Descripcion" rows="2" name="Descripcion" cols="100" placeholder="Ingrese una breve descripción de la promocion"> {{$promocion->Descripcion}}</textarea>
                        </div>



                        <div class="form-group">
                            <button type="submit" name="submit" value="submit" id="submit" class="btn btn-primary"><i class="fa fa-fw fa-plus-circle"></i> Agregar Categoria</button>
                        </div>

                    </form>

                </div>

            </div>



        </div>

    </div>



@endsection

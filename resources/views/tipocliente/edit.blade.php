@extends('welcome')
@section('content')


    <div class="container">
        <div class="card">

            <div class="col-sm-12">
                <h5 class="card-title">Los Campos con <span class="text-danger">*</span> son Obligatorios!</h5>
                <form action="{{route("tiposclientes.update", $tipocliente->IdTipoCliente)}}" method="POST">
                    @csrf
                    @method('put')
                    <div class="form-row">
                        <div class="form-group col-md-7">
                            <label for="Descripcion">Nombre del Tipo<span class="text-danger">*</span></label>
                            <input type="text" name="Descripcion" id="Descripcion" class="form-control" placeholder="Nombre del Servicio" required  value="{{$tipocliente->Descripcion}}">
                        </div>

                    </div>


                        <div class="form-group">
                            <button type="submit" name="submit" value="submit" id="submit" class="btn btn-primary"><i class="fa fa-fw fa-plus-circle"></i> Actualizar Tipo</button>
                        </div>
{{--                    </div>--}}
                </form>

            </div>
        </div>

    </div>



@endsection
